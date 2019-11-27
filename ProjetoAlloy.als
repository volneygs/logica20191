module maquinaDeBebidas
//Assinatura principal: define maquina
sig Maquina{
	copos: set Copo
}

//Assinatura abstrata de copo
abstract sig Copo{
	bebida: one Bebida
}

sig CopoPequeno extends Copo{}
sig CopoGrande extends Copo{}

//Assinatura abstrata de bebida, onde cada bebida deve está ligada à maquina especificamente
abstract sig Bebida{
	comoAdocar: one formaDeAdocar ,
	leite: one colocarLeite
}

//Assinatura dos tipos de Bebida
sig Cafe extends Bebida{}
sig ChocolateQuente extends Bebida{}
sig Cha extends Bebida{}

//Assinatura abstrata para definir sobre forma de adocar
abstract sig formaDeAdocar{}
sig Adocante extends formaDeAdocar{}
sig Acucar extends formaDeAdocar{}
sig SemAcucar extends formaDeAdocar{}

//Assinatura abstrata para definir sobre adicao de leite
abstract sig colocarLeite{}
sig ComLeite extends colocarLeite{}
sig SemLeite extends colocarLeite{}


fact{
Bebida = Cafe + ChocolateQuente + Cha
all m:Maquina | some m.copos
all c:Copo | one c.bebida
all b:Bebida | one b.leite
all b:Bebida | one b.comoAdocar

//Para aparecer somente uma máquina sempre, pode ser retirado
#Maquina = 1

//Quantidade de instancias de Copo é menor ou igual a quantidade das relações Maquina.copos
#Copo <= #Maquina.copos
//Quantidade de instancias de Bebida é menor ou igual a quantidade das relações Copo.bebida
#Bebida <= #Copo.bebida
//Quantidade de instancias de colocarLeite é menor ou igual a quantidade das relações Bebida.leite
#colocarLeite <= #Bebida.leite
//Quantidade de instancias de formaDeAdocar é menor ou igual a quantidade das relações Bebida.comoAdocar
#formaDeAdocar <= #Bebida.comoAdocar
}

pred show[]{}
run show for 3

assert checagem{
//Checa se toda bebida tem exatamente uma definicao sobre leite e uma definicao de como adocar
all b:Bebida | one b.leite and one b.comoAdocar
//Checa se existe algum copo sem bebida
!one b:Copo | #b.bebida = 0
}
check checagem for 10
