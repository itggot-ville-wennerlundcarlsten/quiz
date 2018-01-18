require 'sinatra'
require 'slim'
require 'byebug'


get('/') do
    variabel = "banan"
    slim(:index,locals:{variabel:variabel})
end