#!/bin/bash
######################################################################
#  BATCH......: ESR.sh
#  Descricao: Contador de tempo dos cursos da AlgaWorks
#  Autor: Patrick Farias 30/12/2020
#  Manutencao: patrickfarias@icloud.com
#  Repo: https://github.com/patrickfarias/ShellScript/tree/main/ContadorAlgaWorks
##############################################################################################


######################################################################
# 				Historico:
#
#    v1.0 2020-12-30, Patrick - versao Inicial
######################################################################


##############################################################################################
# 				Historico:
#
# Versao: 1.0 2020-12-30, Patrick - versao Inicial
# Versao: 1.1 2022-10-27, Patrick - Add parametros: [-h | --help] [-v | --version]
#
##############################################################################################

# CONFIGURACAO#
######################
NOME_ARQUIVO_SHELL="$0"
PARAM_01="$1"
NOME_ARQUIVO_FONTE="Fonte.html"

VERSAO=$(grep -n "^# Versao:" $0 | tail -1 | cut -d ' ' -f3)
######################


# REMOCAO DOS ARQUIVOS TEMPORARIO#
######################
rm -rf a1.txt
rm -rf minutos.txt
rm -rf segundos.txt
######################
###################### EXTRACAO DE DADOS ######################
CURSO1=$(grep "l-course-headline__title" $NOME_ARQUIVO_FONTE | cut -d '>' -f2 | cut -d '<' -f1)
grep "c-course-curriculum__lesson-duration" $NOME_ARQUIVO_FONTE | cut -d '>' -f2 | cut -d '<' -f1 > a1.txt
######################

USO="Uso: $(basename "$0") [-h | --help] [-v | --version] | [-p | --print]"

MENSAGEM="$USO

-h, --help		Mostra a tela de Ajuda.
-v, --version 		Mostra a versao.
-p, --print             Mostra a Grade inteira do Curso(Titulo das Video Aulas).

"

###################### MODULOS DO CURSO ######################
grep "chapter-name" $NOME_ARQUIVO_FONTE | cut -d '>' -f2 | cut -d '<' -f1 > Chap.txt
grep "c-course-curriculum__" $NOME_ARQUIVO_FONTE | cut -d '>' -f2 | cut -d '<' -f1 > Chap.txt
grep "c-course-curriculum__lesson-name" $NOME_ARQUIVO_FONTE | cut -d '>' -f2 | cut -d '<' -f1 > Chap.txt

# Tratamento das opcoes de linha de comando
while test -n "$1"
do
	case "$1" in
	
	-h | --help)
		echo "$MENSAGEM"
		exit 0
		;;
		
	-v | --version)
		echo "ESR version: $VERSAO"
		exit 0
		;;

	-p | --print)
		echo "---------- MODULOS: ----------"
		echo 
		echo "Segue abaixo o Titulo das Video aulas"
		echo
		cat Chap.txt		
		echo
		echo
		;;
		
	*)
		
		if test -n "$1"; then
			echo "Opcao Invalida: $1"
			echo "Tente uma das seguintes opcoes: "
			echo "$USO"
			echo
			echo "Ou tente novamente com esses parametros"
			echo "$PARAM"
			exit 1
		fi
		
	esac
	
	shift
	
done
clear
echo "---------- AGARDE UM MOMENTO, estamos gerando o relatório: ----------"

FILE=a1.txt

if [ -f ${arquivo} ]
then

	while read linha; do
	# 22m 51s
	cut -d 'm' -f1 <<< $linha >> minutos.txt
	cut -d 'm' -f2 <<< $linha | sed 's/s//' | cut -c 2- >> segundos.txt

	done < "$FILE"

fi


# coloque todos em uma linha:
#paste -s minutos.txt

#Agora mude o delimitador (-d) de TAB para +,
#paste -s -d + minutos.txt

#basta passar a expresssao resultante para a calculadora do shell:
#paste -s -d + minutos.txt | bc
minutos=$(paste -s -d + minutos.txt | bc)

segundos=$(paste -s -d + segundos.txt | bc)

echo "======================================================================================"
echo "Min: \033[32m$minutos\033[m [ Minutos retirado do Arquivo: $NOME_ARQUIVO_FONTE ]"
echo "Seg: \033[32m$segundos\033[m [ Segundos retirado do Arquivo: $NOME_ARQUIVO_FONTE ]"
echo "======================================================================================"
echo
echo "***************************** AGORA VAMOS AS CONVERSOES ******************************"
echo

echo "---------------------- CONVERTENDO [ \033[32m$segundos\033[m ] SEGUNDOS EM MINUTOS ---------------------"

modSegundosConvertidos=$(($segundos % 60))

minutosConvertidos=$((($segundos - $modSegundosConvertidos) / 60))

echo "$segundos segundos em minutos = $minutosConvertidos minutos e $modSegundosConvertidos segundos"

echo
echo "------------ SOMANDO [ $minutos ] COM OS [ $minutosConvertidos ] MINUTOS QUE FORAM CONVERTIDOS -----------"
somaMinutosTotal=$(($minutos + $minutosConvertidos))

echo "Novo saldo de minutos($minutos + $minutosConvertidos) => [ $somaMinutosTotal ]"

echo
echo "---------------------- CONVERTENDO [ \033[32m$somaMinutosTotal\033[m ] MINUTOS EM HORAS -------------------------"

modMinutosConvertidos=$(($somaMinutosTotal % 60))

horasConvertidos=$((($somaMinutosTotal - $modMinutosConvertidos) / 60))

echo "$somaMinutosTotal em horas = $horasConvertidos horas e $modMinutosConvertidos minutos"

echo
echo "#################################\033[34m R E S U L T A D O \033[m##################################"

echo "O Curso: \033[32m $CURSO1\033[m"
echo "Tem o tempo de: [ \033[31m $horasConvertidos:$modMinutosConvertidos:$modSegundosConvertidos \033[m ] ou [ \033[31m $horasConvertidos horas, $modMinutosConvertidos minutos e $modSegundosConvertidos segundos \033[m]"


echo "######################################################################################"


