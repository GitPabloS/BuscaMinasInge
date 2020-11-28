require 'sinatra'
require './config'
require "./lib/Minas"



def initialize()
    @tableroI= Minas.new
end
get '/' do
    erb :interfazInicio
end

get '/modoJuego' do
    erb :interfazEleccionModoJuego
end
get '/modoJuego/iniciarJuegoNormal' do
    @tableroI.iniciarJuego(8)
    @tableroI.generarMinasTablero8()
    @table=@tableroI.getTableroInterfaz()
    erb :interfazTableroNormal
end
get '/modoJuego/juegoPersonalizado' do
    erb :interfazConfiguracionTableroPersonalizado
end

post '/jugada' do
    @ejeX=params[:ejeX].to_i
    @ejeY=params[:ejeY].to_i
    res = @tableroI.marcarTableroInterfaz(@ejeY-1,@ejeX-1)
    @table=@tableroI.getTableroInterfaz()
   # @c00 = table[0,0]
    erb :interfazTableroNormal
end