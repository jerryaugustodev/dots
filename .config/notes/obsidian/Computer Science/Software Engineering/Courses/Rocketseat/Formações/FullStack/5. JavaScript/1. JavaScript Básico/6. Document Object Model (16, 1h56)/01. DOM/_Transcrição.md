00:00
A partir de agora nós vamos focar no Document Object Model. Você também vai

00:06
ouvir bastante por DOM, principalmente a partir de agora caso você não conheça

00:11.88
ainda, tá? Vamos primeiro entender o que é o DOM, que é uma estrutura super

00:16.56
importante que a gente manipula ela com o JavaScript e aí a gente vai primeiro

00:20.88
entender o conceito para depois colocar isso em prática na sequência, tá? Então

00:25.36
vamos lá, o que é o DOM? Então, preste bastante atenção porque essa

00:29.48
palavrinha vai fazer parte agora do seu dia a dia, principalmente trabalhando com

00:35.6
JavaScript, tá? Então vamos lá, o DOM, que é o Document Object Model, ela é a

00:41.12
representação de dados dos objetos que compõem a estrutura e o conteúdo de um

00:49.68
documento na web, ou seja, uma página. HTML é compreendida como um documento e

00:56.44
dentro desse documento existe uma estrutura e essa estrutura nada mais é

01:2.3200000000000003
do que o DOM. E o DOM usa como representação desse documento nós e

01:10.36
objetos. Então o DOM, ele tem uma estrutura de árvore, daqui a pouco a

01:14.400000000000006
gente vai ver isso, e aí a gente consegue acessar e modificar esses

01:19.840000000000003
elementos que fazem parte dessa estrutura que o DOM traz nesse formato

01:26.439999999999998
de árvore utilizando nós e objeto, tá? Bom, aqui agora trazendo uma ilustração de

01:36.599999999999994
como é o DOM, olha só, a gente tem aqui no topo um documento, ou seja, um

01:43.28
documento, e esse documento nada mais é do que a nossa página HTML. Se a gente

01:50.599999999999994
abrir esse documento e olhar dentro dele, a gente vai encontrar um elemento root,

01:56.760000000000005
que é o próprio HTML em si. Lembra que quando a gente cria um arquivo HTML, um

02:05
dos primeiros conteúdos que a gente coloca ali dentro é que a gente está

02:9.319999999999993
criando um documento e o DOCTYPE, o tipo do documento, é um documento HTML, porque

02:16.360000000000014
também você tem outros tipos de documento além do HTML, tem XML, por

02:21.039999999999992
exemplo, mas aqui a gente está falando de HTML, e dentro do HTML a gente pode ter

02:28.080000000000013
dois nós, que são elementos filhos do nó HTML. Então, olha só, presta bastante

02:37.16
atenção, deixa eu pegar aqui esse laser aqui pra ir sinalizando pra você.

02:42.52000000000001
Olha só, a gente tem aqui um elemento pai, que tem como elemento filho esse

02:48.44
elemento aqui, que é o body, e esse elemento aqui, que é o head. Esse elemento, que é o

02:54.400000000000006
filho desse, também é chamado de children, e você também pode notar que

03:0.47999999999998977
esses elementos nada mais são do que as tags que a gente tem dentro ali do HTML.

03:7.0800000000000125
Então, dentro do head a gente define o title, por exemplo, e aí dentro do title a

03:12
gente coloca o quê? O texto que a gente quer que apareça no título da página,

03:16.039999999999992
como por exemplo, o meu site é o que eu coloquei aqui. Dentro do body é onde a

03:20.919999999999987
gente coloca os elementos que vão ser renderizados e exibidos para o usuário,

03:24.439999999999998
como por exemplo, uma tag, um elemento de H1, que eu quero colocar dentro dele um

03:29.360000000000014
texto Olá, para dar boas-vindas ali para o usuário, por exemplo. E aqui, eu também

03:35.44
posso ter, dentro do body ainda, uma tag P de parágrafo para exibir a mensagem de

03:40.84
é bom ter você por aqui e assim por diante.

03:44.08000000000001
Eu trouxe uma versão bem resumida em chuta, mas pensa nessa, numa página que

03:49.639999999999986
você tem bem completa ali, várias informações de uma aplicação.

03:55.16
Quantos nós você vai ter ali? Com certeza, bastante. Significa que você tem que

04:0.5600000000000023
ficar preocupado em ter muitos ou poucos nós? Claro que não, você vai ver que a

04:7.0800000000000125
forma de manipular isso no JavaScript não vai mudar independente do tamanho da

04:12.47999999999999
sua estrutura que você vai ter dentro do seu documento ali na sua página, tá?

04:17.24000000000001
Então, essa estrutura aqui de um DOM, tá vendo? Um Document Object Model, por isso

04:22.160000000000025
que eu coloquei aqui, inclusive, uma árvore aqui. Olha só, tem aqui vários

04:27.95999999999998
galhos e aí vai ramificando, vai surgindo novos nós, digamos assim.

04:33.95999999999998
Então, essa é a estrutura aqui do DOM. Agora, a gente vai inspecionar para dar

04:41
uma olhada de perto aí, como é a DOM na prática, tá? Então, vamos lá.