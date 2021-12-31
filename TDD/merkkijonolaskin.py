class MerkkijonoLaskin():

    def Laske(value):      

        if value == "":

            return 0

        if ',' in value:

            #print("pilkku")
            lista = value.split(',')
            nlista = []

            for i in lista:
                nlista.append(i)

            a = nlista[0]
            b = nlista[1]

            print(a,b)

            numerolista = map(int, nlista)
            summa = sum(numerolista)
            print(summa)
            #print(lista)
            #numeromap = (int, lista)
            #numerolista = list(numeromap)
            #summa = sum(numerolista)
            #print(summa)
            

            #print(lista)
            
        else:
            print("ei pilkkua")
        return value


    value = "2,4"
    print(value)
    Laske(value)