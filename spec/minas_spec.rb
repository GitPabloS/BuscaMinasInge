require "Minas"
require "spec_helper"

RSpec.describe Minas do
    
    it "Enviar coordenadas X y Y y recibir esas coordenadas" do
        minas=Minas.new
        coordenadas=minas.getCoordenadas(0,1)
        expect(coordenadas).to eq("0-1")
    end

    it "Verificar que las coordenadas no se pasen del tablero" do
        minas=Minas.new
        coordenadas=minas.verificarCoordenadas(0,1)
        expect(coordenadas).to eq(true)
    end

    it "Verificar que las coordenadas se pasaron del tablero" do
        minas=Minas.new
        coordenadas=minas.verificarCoordenadas(-1,8)
        expect(coordenadas).to eq(false)
    end
    it "Verificar que no hay minas en coordenadas del tablero devolviendo 0" do
        minas=Minas.new
        coordenadas=minas.verValorPosicionDelTablero(1,1)
        expect(coordenadas).to eq(0)
    end

    it "Verificar que hay minas en coordenadas del tablero devolviendo 9" do
        minas=Minas.new
        minas.generarMinas()
        coordenadas=minas.verValorPosicionDelTablero(4,4)
        expect(coordenadas).to eq(9)
    end
    it "Verificar que hay un perimetro al rededor de una mina debe devolver 3" do
        minas=Minas.new
        minas.generarMinas()
        coordenadas=minas.verificarPerimetro(7,2)
        expect(coordenadas).to eq(3)
    end
end