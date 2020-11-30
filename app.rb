require 'sinatra'
require './config'
require "./lib/Minas"



def initialize()
    @tableroI= Minas.new
    @contM = 0
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
    # @table=@tableroI.getTableroInterfaz() 
    @stringTablero = @tableroI.obtenerInterfzErbString()
    erb :interfazTablero
end
get '/modoJuego/juegoPersonalizado' do
    erb :interfazConfiguracionTableroPersonalizado
end

post '/modoJuego/juegoPersonalizado/definirParametros' do 
    @tamTablero=params[:tamTablero].to_i
    @numMinas=params[:numMinas].to_i
    if (@tableroI.verificarParametrosPersonalizados(@numMinas,@tamTablero))
        @tableroI.iniciarJuego(@tamTablero)
        @mensajeError = ""
        @stringTablero = @tableroI.obtenerInterfzErbStringBackend()
        erb :interfazGenerarMinas
    else
        @mensajeError = "No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego"
        erb :interfazConfiguracionTableroPersonalizado
    end
end

post '/modoJuego/juegoPersonalizado/definirParametros/generarMinas' do 
    @stringTablero = @tableroI.obtenerInterfzErbStringBackend()
    @ejeX=params[:ejeX].to_i-1
    @ejeY=params[:ejeY].to_i-1
    if (@numMinas != @contM)
        if (@tableroI.getValorPosicionDelTablero(@ejeY,@ejeX) != 9 && @tableroI.verificarCoordenadas(@ejeY,@ejeX))
            @tableroI.generarMina(@ejeY,@ejeX)
            @contM=@contM+1
            @mensajeError = ""
        else
            @mensajeError = "No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego"
            
        end
        erb :interfazGenerarMinas
    else
        erb :interfazTablero
    end
end

post '/jugada' do
    @ejeX=params[:ejeX].to_i
    @ejeY=params[:ejeY].to_i
    res = @tableroI.marcarTableroInterfaz(@ejeY-1,@ejeX-1)
    @stringTablero = @tableroI.obtenerInterfzErbString()
    #@table=@tableroI.getTableroInterfaz()
   # @c00 = table[0,0]
    erb :interfazTablero
end