require "matrix.rb"
require "matrix/eigenvalue_decomposition.rb"
require "matrix/lup_decomposition.rb"
class Minas 
    def initialize
        @filas=8
        @columnas=8
        @tablero = Matrix.zero(@filas, @columnas)
        @tableroInterfaz = Matrix.zero(@filas, @columnas)
    end

    def getCoordenadas(x, y)
        return x.to_s+"-"+y.to_s
    end 

    def verificarCoordenadas(x, y)
        if (x>=0 && y>=0 && x<@filas && y<@columnas)
            return true
        else
            return false
        end 
    end 

    def verValorPosicionDelTablero(x,y)
        return @tablero[x,y]
    end
#Esta funcion es para delimitar el perimetro y no encontramos la forma de implementarlo en un test, 
# ya que, el  codigo final se trabajara con bombas puesta aleatoriamente
    def perimetroDeMina(x,y)
        i=x-1
        j=y-1        
        3.times do 
            3.times do
                if(verificarCoordenadas(i,j) && @tablero[i,j]!=9)
                    @tablero[i,j]=@tablero[i,j]+1
                end
                j=j+1
            end
            j=y-1
            i=i+1
        end
    end
    
    def generarMinas()
        @tablero[1,2]=9
        perimetroDeMina(1,2)
        @tablero[3,2]=9
        perimetroDeMina(3,2)
        @tablero[4,2]=9
        perimetroDeMina(4,2)
        @tablero[5,3]=9
        perimetroDeMina(5,3)
        @tablero[6,0]=9
        perimetroDeMina(6,0)
        @tablero[6,2]=9
        perimetroDeMina(6,2)
        @tablero[4,4]=9
        perimetroDeMina(4,4)
        @tablero[6,3]=9
        perimetroDeMina(6,3)
        @tablero[7,2]=9
        perimetroDeMina(7,2)
        @tablero[7,4]=9
        perimetroDeMina(7,4)
    end

    def verificarPerimetro(x,y)
        i=x-1
        j=y-1
        contador=0        
        3.times do 
            3.times do
                if(verificarCoordenadas(i,j) && @tablero[i,j]!=9)
                    contador=contador+1
                end
                j=j+1
            end
            j=y-1
            i=i+1
        end
        return contador
    end

    def marcarTableroInterfaz(x,y)
        if(verificarCoordenadas(x,y))
            @tableroInterfaz[x,y]=1
        end 

    end

end