module maquinaDeBebidas
//Assinatura principal: define maquina
sig Maquina{
	bebidas: set Bebida
}

//Assinatura abstrata de bebida, onde cada bebida deve está ligada à maquina especificamente
abstract sig Bebida{
	comoAdocar: one formaDeAdocar ,
	leite: one colocarLeite
}
//{
//	one this.~bebidas
//}

//Assinatura dos tipos de Bebida
sig Cafe extends Bebida{}
sig ChocolateQuente extends Bebida{}
sig Cha extends Bebida{}

//Assinatura abstrata da forma de adolar
abstract sig formaDeAdocar{}
{
	one this.~comoAdocar
}
sig Adocante extends formaDeAdocar{}
sig Acucar extends formaDeAdocar{}
sig SemAcucar extends formaDeAdocar{}

//Assinatura abstrata para 
abstract sig colocarLeite{}
//{
//	one this.~leite
//}
sig ComLeite extends colocarLeite{}
sig SemLeite extends colocarLeite{}


fact{
Bebida = Cafe + ChocolateQuente + Cha
all m:Maquina | some m.bebidas
all b:Bebida | one b.leite
all b:Bebida | one b.comoAdocar
//Quantidade de instancias de Bebida é menor ou igual a quantidade das relações Maquina.bebidas
#Bebida <= #Maquina.bebidas
//Quantidade de instancias de colocarLeite é menor ou igual a quantidade das relações Bebida.leite
#colocarLeite <= #Bebida.leite
//Quantidade de instancias de formaDeAdocar é menor ou igual a quantidade das relações Bebida.comoAdocar
#formaDeAdocar <= #Bebida.comoAdocar
}


pred show[]{}
run show for 3
