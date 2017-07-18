#!/usr/bin/ruby -w

# Finds nils in all required variable collumns in a data set

# TO DO:
#  [] un-hard code, so user can choose any file
#  [] NEED TO MAP COLUMNS

require_relative 'Utilities'

#Iterate through the first row in a data set.
#This is the list of variables

data = CSV.read('model/data/AE.csv')

headers = data[0]

def get_data_set
  CSV.read('model/metadata/data_sets.csv', encoding: 'iso-8859-1:utf-8', headers: true)

end



def get_data_name
  file = 'model/data/DM.csv'
  File.basename(file, ".csv")
end

data = CSV.read('model/data/DM.csv')

def checkDataset(name, dataset)

  x= dataset.map{|row| ["#{row['name']}", row['id']]}
  dataset_lookup = Hash[x]

  if dataset_lookup[name]
    puts name + " ID number: " + dataset_lookup[name]

  else
    puts "file (" + name + ") not found in dataset"

  end

end


checkDataset(get_data_name, get_data_set)
puts "all fields: " + headers.to_s



#Check to see if any of these variables are required_variables
required_variables = extractReqs(CSV.read('model/metadata/variables.csv'))

required_headers = []
headers.each do |x|
  if required_variables.include? x
    required_headers.push x
  end
end

puts "required fields:" +  required_headers.to_s

#If they are, check for any nil values in that specific column
data.each do |r|
  #includesNil == false

  r.each do |e|
    if e.nil?
      nildex = r.index(e)
      if required_variables.include?( headers[nildex] )
        #  includesNil == true

        puts ( 'There is a nil value at' + '    ' + headers[nildex] + ' with Case ID ' + '    ' + r[0])
      else
        puts "all required fields are filled"
      end

      break
    end

  end

end
