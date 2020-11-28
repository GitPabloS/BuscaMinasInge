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
    it "Verificar que se marco el perimetro de laa mina" do
        minas=Minas.new
        minas.iniciarJuego(2)
        minas.generarMina(1,1)
        #esto se lo comento ya que la funcion se la llama en la funcion generar mina
        #minas.perimetroDeMina(1,1)
        expect(minas.getValorPosicionDelTablero(1,0)).to eq(1)
        expect(minas.getValorPosicionDelTablero(0,1)).to eq(1)
        expect(minas.getValorPosicionDelTablero(0,0)).to eq(1)
    end

    it "Verificar que se marco el perimetro de la mina" do
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
        minas.generarMina(1,1)
        minas.marcarTableroInterfaz(1,1)
        minas.marcarTableroInterfaz(1,0)
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq("1")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq("*")
        minas.reiniciarJuego()
        expect(minas.getValorPosicionDelTableroInterfaz(0,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(0,1)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,0)).to eq(" ")
        expect(minas.getValorPosicionDelTableroInterfaz(1,1)).to eq(" ")
    end

    it "Verificar que se genere string dsel erb correctasmente segun el tamaño del tablero" do
        minas=Minas.new
        minas.iniciarJuego(2)
        expect(minas.obtenerInterfzErbString()).to eq("<table><tr><td> </td><td> </td></tr><tr><td> </td><td> </td></tr><table>")
    end
end