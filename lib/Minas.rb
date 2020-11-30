require "matrix.rb"
require "matrix/eigenvalue_decomposition.rb"
require "matrix/lup_decomposition.rb"
class Minas 
    def initialize()
        @tamanho=""
        @tablero = ""
        @tableroInterfaz = ""
        @tableroDescubierto = ""
    end
    #CAmbie Reiniciar juego por comenzarJuego ya que ahora vamos tener un menu de inicioS
    def iniciarJuego(tam)
        @tamanho=tam
        @tablero = Matrix.zero(@tamanho, @tamanho)
        @tableroInterfaz = Matrix.build(tam) { " " }
        @tableroDescubierto = Matrix.build(tam) { false }
    end
    def reiniciarJuego()
        @tableroInterfaz = Matrix.build(@tamanho) { " " }
        @tableroDescubierto = Matrix.build(@tamanho) { false }
        #@tableroInterfaz = Matrix[[" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",], [" "," "," "," "," "," "," "," ",]]
    end

    def verificarCoordenadas(x, y)
        if (x>=0 && y>=0 && x<@tamanho && y<@tamanho)
            return true
        else
            return false
        end 
    end 
    
    def getValorPosicionDelTablero(x,y)
        if( verificarCoordenadas(x,y))
            return @tablero[x,y]
        end
    end

    def generarMina(x,y)
        if verificarCoordenadas(x,y)
            @tablero[x,y] = 9
            perimetroDeMina(x,y)
        end
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
    
    def generarMinasTablero8()
        @tablero[1,2] = 9
        perimetroDeMina(1,2)
        @tablero[3,2] = 9
        perimetroDeMina(3,2)
        @tablero[4,2] = 9
        perimetroDeMina(4,2)
        @tablero[5,3] = 9
        perimetroDeMina(5,3)
        @tablero[6,0] = 9
        perimetroDeMina(6,0)
        @tablero[6,2] = 9
        perimetroDeMina(6,2)
        @tablero[4,4] = 9
        perimetroDeMina(4,4)
        @tablero[6,3] = 9
        perimetroDeMina(6,3)
        @tablero[7,2] = 9
        perimetroDeMina(7,2)
        @tablero[7,4] = 9
        perimetroDeMina(7,4)
    end
    
    def getTableroInterfaz()
        return @tableroInterfaz
    end

    def getValorPosicionDelTableroInterfaz(x,y)
        if( verificarCoordenadas(x,y))
            return @tableroInterfaz[x,y]
        end
    end

    def marcarTableroInterfaz(x,y)
        if(verificarCoordenadas(x,y) && @tableroInterfaz[x,y]==" ")
            if @tablero[x,y] == 9
                @tableroInterfaz[x,y]="*"
            else
                @tableroInterfaz[x,y]=@tablero[x,y].to_s
            end
           
        end 
    end

    def obtenerInterfzErbString()
        i=0
        j=0
        stringErb = "<table>"
        @tamanho.times do
            stringErb = stringErb + "<tr>"
            @tamanho.times do
                stringErb = stringErb + "<td>" + @tableroInterfaz[i,j] + "</td>"
                j=j+1
            end
            stringErb = stringErb + "</tr>"
            j=0
            i=i+1
        end
        stringErb = stringErb + "</table>"
        return stringErb
    end

    def verificarParametrosPersonalizados(numMinas,tamTablero)
        res=false
        if (numMinas>0 && tamTablero>0)
            if (numMinas<=((tamTablero*tamTablero)/3))
                res=true
            end
        end
        return res
    end

    
    def obtenerInterfzErbStringBackend()
        i=0
        j=0
        stringErb = "<table>"
        @tamanho.times do
            stringErb = stringErb + "<tr>"
            @tamanho.times do
                stringErb = stringErb + "<td>" + @tablero[i,j].to_s + "</td>"
                j=j+1
            end
            stringErb = stringErb + "</tr>"
            j=0
            i=i+1
        end
        stringErb = stringErb + "</table>"
        return stringErb
    end
end