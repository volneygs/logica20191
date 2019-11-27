module maquinaDeBebidas

--ASSINATURAS--
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

//Assinatura abstrata de bebida
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

--FATOS--
//O conjunto de bebidas e formado pela uniao de todos os cafes, chocolates quentes e chas
fact conjuntoBebidas{
Bebida = Cafe + ChocolateQuente + Cha
}

//Cada maquina possui pelo menos um copo
fact quantCopos{
all m:Maquina | some m.copos
}

//Cada Copo possui exatamente uma bebida
fact quantBebidasPorCopo{
all c:Copo | one c.bebida
}

//Cada Bebida possui exatamente uma definicao sobre adicao do leite
fact quantDefLeitePorBebida{
all b:Bebida | one b.leite
}

//Cada bebida possui exatamente uma definicao de forma de adocar
fact quantDefComoAdocarPorBebida{
all b:Bebida | one b.comoAdocar
}

//So existe uma máquina
fact quantMaquina{
#Maquina = 1
}

fact quantInstancias{
//Quantidade de instancias de Copo é menor ou igual a quantidade das relações Maquina.copos
#Copo <= #Maquina.copos
//Quantidade de instancias de Bebida é menor ou igual a quantidade das relações Copo.bebida
#Bebida <= #Copo.bebida
//Quantidade de instancias de colocarLeite é menor ou igual a quantidade das relações Bebida.leite
#colocarLeite <= #Bebida.leite
//Quantidade de instancias de formaDeAdocar é menor ou igual a quantidade das relações Bebida.comoAdocar
#formaDeAdocar <= #Bebida.comoAdocar
}

--ASSERTS--
//Checa se toda bebida tem exatamente uma definicao sobre leite e uma definicao de como adocar
assert checaDefinicaoDeLeiteEComoAdocar{
all b:Bebida | one b.leite and one b.comoAdocar
}

//Checa se existe algum copo sem bebida
assert checaSeExisteCopoSemBebida{
!one b:Copo | #b.bebida = 0
}

--EXECUCOES--
check checaDefinicaoDeLeiteEComoAdocar for 5
check checaSeExisteCopoSemBebida for 5

pred show[]{
}
run show for 3
