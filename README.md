# 🐧 Linux-Basic

## 📄 Descrição

Script em Bash para a criação de um sistema Linux Desktop com foco em **desempenho e simplicidade**.

Durante instalações comuns, até mesmo ao selecionar apenas o "XFCE", o sistema inclui diversos pacotes que rodam em segundo plano. Isso ocorre porque assume-se que o usuário queira um ambiente completo — o que nem sempre é o caso.

A proposta aqui é diferente: realizar uma instalação **mínima**, adicionando **somente** o que será realmente usado. Assim, teremos um sistema funcional e com **máximo desempenho**.

Neste guia, usaremos o **Debian 12 (Bookworm)** como base para a instalação.

---

## ⚙️ Pré-requisitos

- Imagem ISO minimalista (Debian NetInstall)
- Ambiente de virtualização (ex: VirtualBox)
- Conexão com a internet
- Conhecimentos básicos em linha de comando

---

## 🚀 Passo a passo da instalação

### 1. Tela inicial após o boot  
![Instalação do sistema](/assets/Instalação.png)

Vamos prosseguir com a instalação **sem interface gráfica**.

---

### 2. Seleção de idioma  
![Língua Sistema](assets/Lingua.png)

Recomendo usar **inglês**, pois a maioria dos comandos será nesse idioma. No entanto, português também é aceito.

---

### 3. Localidade  
![Localidade](assets/localidade.png)

Selecione seu país para configurar corretamente o **fuso horário** e as opções de **locale**.

---

### 4. Tipo de teclado  
![Seleção de formato do teclado](assets/Teclado.png)

Para teclados brasileiros, selecione **Português brasileiro (UTF-8)**. Isso garante acesso a caracteres como `ç`, `^`, `/` etc.

---

### 5. Hostname e domínio  
![Hostname](assets/hostname.png)  
![Domínio da rede](assets/dominio.png)

- **Hostname:** Nome da sua máquina na rede. Pode ser qualquer um.
- **Domínio:** Como estamos em uma rede doméstica, pode deixar em branco.

---

### 6. Senha do root  
![Definir senha root](assets/senharoot.png)  
![Confirmar senha root](assets/confirmarSenhaRoot.png)

Defina uma senha forte para o usuário root (administrador do sistema).

---

### 7. Criação do primeiro usuário  
![Primeiro usuário do sistema](assets/primeiroUsuario.png)  
![Nome do usuário](assets/nomeUserConta.png)

Crie o usuário comum. O sistema irá sugerir o nome de usuário com base no nome inserido.

---

### 8. Senha do usuário  
![Senha primeiro usuário](assets/SenhaUsuario.png)  
![Confirmar senha usuário](assets/ConfirmarSenhaUser.png)

Defina e confirme a senha do usuário comum, que será usada no dia a dia.

---

### 9. Fuso horário  
![Fuso horário](assets/FusoHorario.png)

Selecione o fuso horário. No exemplo, utilizamos o **Distrito Federal**.

---

## 💾 Particionamento do disco

### 10. Escolha do tipo de particionamento  
![Seleção Particionamento](assets/ParticionarDisco.png)

- **Assistido – usar disco inteiro:** Particionamento automático.
- **Assistido – usar LVM:** Agrupa partições logicamente.
- **Assistido – LVM criptografado:** Recomendado para notebooks (maior segurança).
- **Manual:** Mais flexível e ideal para quem deseja controle total.

---

### 11. Criando as partições  
![Seleção do armazenamento a ser particionado](assets/EspacoParticao.png)

Usaremos um exemplo com 20GB no VirtualBox, e outro do meu HD real de 1TB.

---

### 12. Resultado final do particionamento  
![Particionamento final](assets/ParticionamentoFinal.png)

Exemplo de particionamento:

- `/swap`: Área de troca que auxilia a RAM em situações de uso intenso. **Atenção:** o swap não substitui a RAM.
- `/boot`: Onde ficam o kernel e arquivos essenciais de boot.
- `/`: Raiz do sistema, onde ficam os arquivos do sistema e programas.
- `/home`: Espaço pessoal do usuário (documentos, vídeos, jogos etc).

#### Exemplo real (PC pessoal):

- `/boot/efi` – 512MB (UEFI)
- `/boot` – 2GB  
- `/` – 60GB  
- `swap` – 12GB  
- `/home` – restante do armazenamento

---

### 13. Confirmação do particionamento  
![Confirmar Particionamento](assets/ConfirmarParticionamento.png)

---

## 📦 Configuração de pacotes

### 14. Instalação de mídias adicionais  
![Gerenciador de pacotes](assets/pacotes.png)

Selecione **"Não"**, pois a instalação básica já está carregada. O restante será baixado da internet.

---

### 15. Repositórios e localidade  
![Região pacote](assets/LocalPacote.png)  
![Região pacote 2](assets/localPacotes.png)

Escolha o repositório `deb.debian.org` e a localidade **Brasil** para menor latência.

---

### 16. Proxy de rede  
![Proxy](assets/proxy.png)

Caso não use proxy, deixe em branco.

---

### 17. Participação em estatísticas  
![Concurso de pacotes](assets/ConcursoPacote.png)

Pode aceitar ou recusar. O sistema só coleta informações sobre pacotes instalados, sem invadir sua privacidade.

---

### 18. Seleção de software  
![Seleção de softwares](assets/SeleçãoSoftware.png)

⚠️ **Desmarque todas as opções** exceto, se desejar, o **SSH server**.  
Não selecione XFCE aqui — isso instalará muitos pacotes desnecessários. Instalaremos depois manualmente.

---

## 🔧 Finalizando a instalação

### 19. Instalação do GRUB  
![Instalador GRUB](assets/GRUB.png)  
![Local do GRUB](assets/LOCALGRUB.png)

Instale o GRUB no disco principal para permitir o boot do sistema.

---

### 20. Conclusão  
![Reboot](assets/FIM.png)

Clique em **"Continuar"** para reiniciar o sistema.  
Após isso, você será levado ao terminal de login. Faça login com o usuário criado anteriormente.

---

## ✅ Próximos Passos

Agora com seu sistema mínimo pronto, entre como root usando "su -", faça o download do git usando "apt install git".
Após isso faça o clone do repositorio e rode o script.

