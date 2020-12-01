require "Minas"
require "spec_helper"

RSpec.describe Minas do
    
    it "Verificar que el tablero se creo correctamente y se lleno de ceros(1x1)" do
        minas=Minas.new
        minas.iniciarJuego(1)
        expect(minas.getValorPosicionDelTablero(0,0)).to eq(0)
    end 
    it "Verificar que el tablero se creo correctamente y se lleno de ceros(2x2)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.getValorPosicionDelTablero(0,0)).to eq(0)
        expect(minas.getValorPosicionDelTablero(0,1)).to eq(0)
        expect(minas.getValorPosicionDelTablero(1,0)).to eq(0)
        expect(minas.getValorPosicionDelTablero(1,1)).to eq(0)
    end 

    it "Verificar que las coordenadas no se pasen del tablero" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.verificarCoordenadas(0,1)).to eq(true)
    end

    it "Verificar que las coordenadas se pasaron del tablero" do
        minas=Minas.new
        minas.iniciarJuego(2)
        coordenadas=minas.verificarCoordenadas(-1,8)
        expect(coordenadas).to eq(false)
    end
    it "Verificar que no hay minas en coordenadas del tablero devolviendo 0" do
        minas=Minas.new
        minas.iniciarJuego(2)
        coordenadas=minas.getValorPosicionDelTablero(1,1)
        expect(coordenadas).to eq(0)
    end

    it "Verificar que hay minas en coordenadas del tablero devolviendo *" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.generarMina(1,1)
        coordenadas=minas.getValorPosicionDelTablero(1,1)
        expect(coordenadas).to eq(9)
    end
    it "Verificar que se marco el perimetro de la mina" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.generarMina(1,1)
        #esto se lo comento ya que la funcion se la llama en la funcion generar mina
        #minas.perimetroDeMina(1,1)
        expect(minas.getValorPosicionDelTablero(1,0)).to eq(1)
        expect(minas.getValorPosicionDelTablero(0,1)).to eq(1)
        expect(minas.getValorPosicionDelTablero(0,0)).to eq(1)
    end

    it "Verificar que se marco el perimetro de las minas" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.generarMina(1,1)
        minas.generarMina(0,0)
        expect(minas.getValorPosicionDelTablero(1,0)).to eq(2)
        expect(minas.getValorPosicionDelTablero(0,1)).to eq(2)
    end

    it "Verificar que el tablero se creo correctamente y se lleno de espacios (1x1)" do
        minas=Minas.new
        minas.iniciarJuego(1)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
    end

    it "Verificar que el tablero se creo correctamente y se lleno de espacios (2x2)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
    end

    it "Verificar que Marca el Tablero de la interfaz" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.generarMina(1,1)
        minas.marcarTableroInterfaz(1,1)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq("*")
    end
    it "Verificar que devuelve el Tablero de la interfaz" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.getTableroInterfaz()).to eq(Matrix[[" "," "],[" "," "]])
    end

    it "Verificar que se reinicia el tablero interfaz con las bombas en su mismo lugar" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.incertarNumMinasPorIncertar(1)
        minas.incertarMina(1,1)
        minas.marcarTableroInterfaz(0,1)
        minas.marcarTableroInterfaz(1,0)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
        minas.reiniciarJuego()
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
    end

    it "Verificar que se genere string del erb correctasmente segun el tamaño del tablero" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.obtenerInterfzErbString()).to eq("<table><tr><td> </td><td> </td></tr><tr><td> </td><td> </td></tr></table>")
    end

    it "Verificar que el numero de minas y el tamaño del tablero son positivos y mayor a cero" do
        minas=Minas.new
        verificador = minas.verificarParametrosPersonalizados(1,8) 
        expect(verificador).to eq(true)
    end

    it "Verificar si el numero de minas ingresados es negativa" do
        minas=Minas.new
        verificador = minas.verificarParametrosPersonalizados(-1,8) 
        expect(verificador).to eq(false)
    end

    it "Verificar si el tamaño del tablero ingresado es negativa" do
        minas=Minas.new
        verificador = minas.verificarParametrosPersonalizados(1,-8) 
        expect(verificador).to eq(false)
    end

    it "Verificar el numero de minas es menor a 1/3 del numero de casillas del tablero" do
        minas=Minas.new
        #El numero de casillas es el tamaño del tablero al cuadrado, en este caso seria 64 casillas
        verificador = minas.verificarParametrosPersonalizados(23,8) 
        expect(verificador).to eq(false)
    end

    it "Verificar el numero de minas es menor a 1/3 del numero de casillas del tablero" do
        minas=Minas.new
        #El numero de casillas es el tamaño del tablero al cuadrado, en este caso seria 81 casillas
        verificador = minas.verificarParametrosPersonalizados(27,9) 
        expect(verificador).to eq(true)
    end

    it "Verificar que se genere string del erb correctasmente con el tablero del backend(1)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.obtenerInterfzErbStringBackend()).to eq("<table><tr><td>0</td><td>0</td></tr><tr><td>0</td><td>0</td></tr></table>")
    end

    it "Verificar que se genere string del erb correctasmente con el tablero del backend(2)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.generarMina(1,1)
        expect(minas.obtenerInterfzErbStringBackend()).to eq("<table><tr><td>1</td><td>1</td></tr><tr><td>1</td><td>9</td></tr></table>")
    end
    it "Obtener las respuestas para el ingreso de las minas(1)" do
        minas=Minas.new
        minas.incertarNumMinasPorIncertar(4)
        minas.iniciarJuego(4)
        res=minas.incertarMina(0,1)
        expect(res).to eq(["",3])
    end
    it "Obtener las respuestas para el ingreso de las minas(2)" do
        minas=Minas.new
        minas.incertarNumMinasPorIncertar(4)
        minas.iniciarJuego(4)
        res=minas.incertarMina(0,1)
        expect(res).to eq(["",3])
        res=minas.incertarMina(0,1)
        expect(res).to eq(["No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego",3])
        res=minas.incertarMina(0,-1)
        expect(res).to eq(["No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego",3])
        res=minas.incertarMina(0,0)
        expect(res).to eq(["",2])
        res=minas.incertarMina(3,1)
        expect(res).to eq(["",1])
        res=minas.incertarMina(2,3)
        expect(res).to eq(["",0])
    end

    it "Verificar Si es que sigue el juego o ya termino(1)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.incertarNumMinasPorIncertar(1)
        minas.incertarMina(1,1)
        minas.marcarTableroInterfaz(1,0)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
        expect(minas.sigueElJuego()).to eq("")
    end
    it "Verificar Si es que sigue el juego o ya termino(2)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.incertarNumMinasPorIncertar(1)
        minas.incertarMina(1,1)
        minas.marcarTableroInterfaz(1,0)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
        expect(minas.sigueElJuego()).to eq("")

        minas.marcarTableroInterfaz(1,1)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq("*")
        expect(minas.sigueElJuego()).to eq("Que pena, Perdiste")

    end

    it "Verificar Si es que sigue el juego o ya termino(3)" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.incertarNumMinasPorIncertar(1)
        minas.incertarMina(1,1)
        minas.marcarTableroInterfaz(1,0)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
        expect(minas.sigueElJuego()).to eq("")

        minas.marcarTableroInterfaz(0,1)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
        expect(minas.sigueElJuego()).to eq("")

        minas.marcarTableroInterfaz(0,0)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
        expect(minas.sigueElJuego()).to eq("Felicitaciones Ganaste")
    end
end