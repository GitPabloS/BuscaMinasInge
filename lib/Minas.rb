require "matrix.rb"
require "matrix/eigenvalue_decomposition.rb"
require "matrix/lup_decomposition.rb"
class Minas 
    def initialize()
        @tamanho=""
        @tablero = ""
        @tableroInterfaz = ""
        @tableroDescubierto = ""
        @numMinPorIncertar=0
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
        generarMina(1,2)
        generarMina(3,2)
        generarMina(4,2)
        generarMina(5,3)
        generarMina(6,0)
        generarMina(6,2)
        generarMina(4,4)
        generarMina(6,3)
        generarMina(7,2)
        generarMina(7,4)
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

    def incertarNumMinasPorIncertar(numMinas)
        @numMinPorIncertar= numMinas
    end

    def incertarMina(x,y)
        if (getValorPosicionDelTablero(x,y) != 9 && verificarCoordenadas(x,y))
            generarMina(x,y)
            mensajeError=""
            @numMinPorIncertar=@numMinPorIncertar-1
        else
            mensajeError="No ingresaste el tamaño del tablero y/o el numero de minas acorde a las reglas del juego"
            notificacionDeIngresoMina=false
        end
        return [mensajeError, @numMinPorIncertar]
    end
end