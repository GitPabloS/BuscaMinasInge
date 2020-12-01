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
        @tableroI.incertarNumMinasPorIncertar(@numMinas)
        @stringTablero = @tableroI.obtenerInterfzErbStringBackend()
        erb :interfazGenerarMinas
    else
        @mensajeError = "No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego"
        erb :interfazConfiguracionTableroPersonalizado
    end
end

post '/modoJuego/juegoPersonalizado/definirParametros/generarMinas' do 
    @ejeX=params[:ejeX].to_i-1
    @ejeY=params[:ejeY].to_i-1
    @mensajeError,@numMinas=@tableroI.incertarMina(@ejeY,@ejeX)
    @stringTablero = @tableroI.obtenerInterfzErbStringBackend()
    if (@numMinas > 0)
        # if (notificacionMina)
        #     @tableroI.generarMina(@ejeY,@ejeX)
        #     @contM=@contM+1
        #     @mensajeError = ""
        # else
        #     @mensajeError = "No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego"
            
        # end
        erb :interfazGenerarMinas
    else
        @stringTablero = @tableroI.obtenerInterfzErbString()
        erb :interfazTablero
    end
end

post '/jugada' do
    @ejeX=params[:ejeX].to_i
    @ejeY=params[:ejeY].to_i
    @tableroI.marcarTableroInterfaz(@ejeY-1,@ejeX-1)
    @mensajeFinJuego=@tableroI.sigueElJuego()
    @stringTablero = @tableroI.obtenerInterfzErbString()
    #@table=@tableroI.getTableroInterfaz()
   # @c00 = table[0,0]
    erb :interfazTablero
end

get '/reglas' do
    erb :interfazReglas
end
get '/reiniciar' do

    @tableroI.reiniciarJuego()
    @stringTablero = @tableroI.obtenerInterfzErbString()
   # @c00 = table[0,0]
    erb :interfazTablero
end