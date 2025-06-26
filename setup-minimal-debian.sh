#!/bin/bash
#
#--------------------------------------------------------------------------------#
# Nome do Script : setup-minimal-debian.sh				 	 					 #
# Autor          : Leandro França					 	 						 #
# Data de Criação: 24/06/2025						       	 					 #
# Versão         : 1.0								 							 #
#										 										 #
# Descrição:									 								 #
#   Este script realiza a configuração inicial mínima do			 			 #
#   Debian 12 (Bookworm) com interface gráfica XFCE.				 			 #
#   Ideal para instalações leves e funcionais.					 				 #
#										 										 #
# Funcionalidades:								 								 #
#   - Verifica se está sendo executado como root				 				 #
#   - Solicita nome de um usuário válido e adiciona ao grupo sudo		 		 #
#   - Substitui o sources.list com repositórios completos			 			 #
#   - Atualiza o sistema e instala pacotes básicos e o XFCE			 			 #
#   - Remove pacotes desnecessários e limpa o cache				 				 #
#   - Reinicia o sistema ao final						 						 #
#										  										 #
# Requisitos:									 								 #
#   - Conexão com a internet (necessário para baixar pacotes)			 		 #
#										 										 #
# Uso:										 									 #
#   Baixe o repositório do github usando:					 					 #
#	# git clone https://github.com/Leandro-de-Almeida-Franca/Linux-Basic.git 	 # 
#   Execute como root:								 							 #
#     # bash setup-minimal-debian.sh						 					 #
#										 										 #
#--------------------------------------------------------------------------------#


#Funções para as cores
info() { echo -e "\e[1;36m[INFO]\e[0m $1"; }
ok()   { echo -e "\e[1;32m[OK]\e[0m $1"; }
warn() { echo -e "\e[1;33m[!]\e[0m $1"; }
err()  { echo -e "\e[1;31m[ERRO]\e[0m $1"; }

#Verifica permissão de root
if [ "$EUID" -ne 0 ]; 
then
	warn "Execute o script como root"
	warn "Como logar como root:"
	warn "	su - <senha root>"
	exit 1
fi

#Pede nome de usuário
read -p "Digite o nome do usuário que vai receber permissão de sudo:" usuario

#Verifica se algum paremetro foi colocado
if [ -z "$usuario" ];
then
	err "Insira um nome de usuário"
	info "Recomendado ter um usuário com permissão para não logar como root sempre"
	exit 2
fi

#Verifica se o usuário existe
if ! id "$usuario" &>/dev/null;
then
	err "Usuário '$usuario' não existe no sistema."
	exit 3
fi

#Verifica conexão com internet
if ! ping -c 1 -q google.com &>/dev/null;
then
	err "Sem conexão com a internet. Coneccte-se antes de executar o script."
	exit 4
fi

#Repositorios que serão usados pelo sistema
repositorios="# Debian Bookworm - Repositórios Oficiais
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

# Atualizações de Segurança
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

# Atualizações Estáveis (Updates)
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

# Backports (Pacotes mais recentes)
deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware

# Repositório do XFCE (Opcional)
# deb https://mirrors.ircam.fr/pub/xfce/xfce-4.18/bookworm/ /"

#Atualizando o sistema base
info "Atualizando o sistema..."
sleep 3
apt update -y && apt upgrade -y
sleep 3
clear
ok "Sistema atualizado com sucesso"
#Instalando alguns pacotes para o sistema
info "Instalando pacotes para o sistema..."
info "Esta etapa pode demorar."
sleep 5
# bash-completion: completa comandos com TAB
# htop: monitor de processos
# vim: editor de texto em terminal
# sudo: para executar comandos com privilégios
# xorg: servidor gráfico
# xfce4: ambiente gráfico completo
# xfce4-terminal: terminal do XFCE
# lightdm: gerenciador de login
# neofetch: exibe informações do sistema

apt install -y \
	bash-completion \
	htop \
	vim \
	sudo \
	xorg \
	xfce4 \
	xfce4-terminal \
	lightdm \
	neofetch
sleep 1
clear
ok "Pacotes instalados com sucesso"
info "Atualizando sources.list"
# Substituindo o sources.list para um mais completo
echo "$repositorios" > /etc/apt/sources.list
ok "Sources.list atualizado com sucesso"
sleep 3
clear
#Removendo pacotes que não vamos usar
info "Removendo pacotes desnecessários..."
apt remove xterm -y
apt autoremove -y
sleep 3

#Adicionando o usuario ao sudo
info "Adicionando usuário ao sudoers..."
usermod -aG sudo "$usuario"
sleep 2
ok "Usuário agora pode usar o comando sudo.   "
sleep 2
#Atualizando o sistema com os novos pacotes e sources.list
info "Atualizando novos pacotes..."
sleep 3
apt update -y && apt upgrade -y
clear
ok "Novos pacotes atualizados."
#Limpar cache
info "Limpando cache de pacotes..."
apt clean
sleep 5
echo "#############################################"
echo "#     Debian Bookworm com XFCE Instalado!   #"
echo "#      Configuração concluida com êxito!    #"
echo "#############################################"
sleep 2
#Finalização
ok "Sistema pronto para uso."
info "O sistema vai reiniciar..."
sleep 1
info "Reiniciando em 5 segundos..."
sleep 1
info "Reiniciando em 4 segundos..."
sleep 1
info "Reiniciando em 3 segundos..."
sleep 1
info "Reiniciando em 2 segundos..."
sleep 1
info "Reiniciando em 1 segundo..."
sleep 1
info "Reiniciando..."
reboot
