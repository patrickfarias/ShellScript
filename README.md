# Contador de Tempo das Video Aulas.
> Curso ESR - Especialista Sping Rest (AlgaWorks)

## Exemplo de Uso:

Para utilizar o script, basta ter o bash instado em sua máquina.

No diretorio _ContadorAlgaWorks_, basta digitar:

```sh
sh ESR.sh
```
![](screenshot_001.png)

## Será que funciona?

Para validar se o escript esta realmente funcional.

Entre dentro do arquivo _./ShellScript/ContadorAlgaWorks/Fonte.html_ e altere algum campo com com esse formato
e altere por exemplo uma linha como essa:

DE:<br>
<code>"c-course-curriculum__lesson-duration">24m 57s</code>

PARA:<br>
<code>"c-course-curriculum__lesson-duration">23m 55s</code>

e salve o arquivo Fonte.html.

Rode o script novamente, como foi alterado o tempo informado como sendo de 1 minuto e 2 segundos a menos.
O Resultado final deve dar 1 minuto e 2 segundo a menos no total informado no relatorio.

Brinque com outros valores e comprove.

> ATENCAO: Esse recurso vale para outros cursos da AlgaWorks, se for aluno, basta entrar na pagina do seu curso com o seu usuario e senha, e copiar o fonte da pagina do curso que vc quiser calcular o tempo e colar no arquivo ./Fonte.html e rodar o script, que ele vai calcular o tempo total do curso.



## Histórico de Releases:
* 1.1
    * 2022-10-30 - Patrick Farias
    * Adicionado Add parametros: [-h | --help] [-v | --version]  [-p | --print]
   
* 1.0
    * Start (2020-12-30)

## Contato

Patrick Farias – patrickfarias@icloud.com –
(34)99304-0500

[https://github.com/patrickfarias/ShellScript](https://github.com/patrickfarias/ShellScript)
