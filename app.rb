require 'sinatra'
require './config'
require "./lib/Minas"



def initialize()
    @tableroI= Minas.new()
end

get '/' do
    @tableroI.generarMinas()
    erb :tablero
end


post '/coordenadas' do
    @ejeX=params[:ejeX].to_i
    @ejeY=params[:ejeY].to_i
    @tableroI.marcarTableroInterfaz(@ejeX-1,@ejeY-1)
    erb :tablero
end