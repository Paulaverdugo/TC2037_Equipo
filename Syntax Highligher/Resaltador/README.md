# Actividad Integradora 3.4 

## Descripción de la Evidencia

Desarrollo de un analizador léxico que categoriza y resalta elementos léxicos en código fuente. Generación de documentos HTML para mostrar la estructura léxica. Implementación funcional y análisis de algoritmos.

## Tabla de Contenidos

- [Instrucciones](#instrucciones)
- [Resultados](#resultados)
- [Conclusiones](#conclusiones)

## Instrucciones

Como utilizar el resaltador de syntaxis.

1. Baja el documento syntaxhighlighter.exs y los ejemplos prueba de python
2. El archivo utilizado para el resaltador es "example.py". Si se quiere cambiar de archivo, hasta abajo del syntax highlighter, existe la línea de código dónde se debe editar con el nombre el archivo deseado. Es importante que el archivo de python y el archivo de elixir estén en el mismo folder.

### Línea de código:
    Syntaxhighlighter.highlight("example.py")

3. Para correrlo en la terminal se necesita escribir:
- iex syntaxhighlighter.exs

    Con esto el archivo se correrá y aparecerá el archivo HTML llamado "highlighted.html"


## Categorías Lexicas

Para crear el resaltador de syntaxis en Elixir para el lenguaje de programación python se consideró todas las caracteristicas de este lenguaje. Nuestro resaltador de sintaxis toma en cuenta las siguientes categorías:
- Strings
- Comentarios
- Números
- Operadores de matemáticos
- Puntuación (.|;|,|:)
- Palabras clave de python (def|if|else|elif|for|while|in|return|try|import|break|except|print)
- Expresiones booleanas
- Funciones 
- Paréntesis
- Llaves
- Brackets
- Métodos
- Operadores logicos


## Expresiones Regulares

- Strings: ~r/("[^"\\](?:\\.[^"\\])")/, ~r/('[^'\\](?:\\.[^'\\])'
- Comentarios: 
- Números: ~r/(\d+)/ 
- Operadores de matematicos: ~r/(\+|-|\*
- Puntuación: ~r/(\.|;|:|\,)/
- Palabras clave de python: ~r/\b(def|if|else|elif|for|while|in|return|try|import|break|except|print)\b/
- Expresiones booleanas: ~r/\b(True|False)\b/
- Funciones: ~r/\b(\w+)\(/
- Paréntesis: ~r/(\(|\))/
- Llaves: ~r/(\{|\})/
- Brackets: ~r/(\[|\])/
- Métodos: ~r/\.(?!\d)\w+/
- Operadores lógicos: ~r/\b(and|or|not|\/)\b/

## Resultados
El resaltador de sintaxis utiliza expresiones regulares para identificar y resaltar palabras específicas en un archivo Python. Este proceso implica transformar el archivo en un documento HTML, donde cada palabra identificada se resalta de manera distinta utilizando estilos y etiquetas HTML adecuadas. El resaltador de sintaxis es capaz de destacar elementos como strings, comentarios, números, operadores, expresiones booleanas, palabras clave, etc. Al final, se obtiene un archivo HTML visualmente atractivo que muestra el código Python con las palabras resaltadas de forma distintiva, facilitando la lectura y comprensión del código.


## Complejidad del Algoritmo

El algoritmo utiliza un ciclo para analizar cada renglón del documento python. Esto significa que entre más grande sea el documento en cuestión, mayor complejidad del algoritmo.
La complejidad de nuestro algoritmo es: O(n^2)

Esta complejidad no es ideal, especialmente cuando trabajamos con archivos de gran tamaño. En situaciones en las que necesitamos procesar una gran cantidad de datos, es importante tener en cuenta la eficiencia del algoritmo y buscar formas de optimizarlo. En este caso, podría ser beneficioso explorar opciones como algoritmos de complejidad lineal o incluso sublineal, si es posible, para mejorar el rendimiento del resaltador de sintaxis.

## Conclusiones

La complejidad de nuestro algoritmo es de orden O(m), lo que significa que su tiempo de ejecución aumenta cuadráticamente con el tamaño de entrada. Esto se debe a que utilizamos un ciclo para iterar sobre todo el archivo de Python proporcionado. A medida que el tamaño del archivo aumenta, el programa tardará cada vez más en ejecutarse debido a esta complejidad.

Para crear el resaltador de sintaxis, se utilizaron cinco funciones diferentes. El proceso comienza con la función que lee el archivo proporcionado. Si se logra leer correctamente, se inicia el procedimiento de resaltado de sintaxis. A continuación, se utiliza una función para separar cada línea del archivo de Python. Esta división por líneas nos permite procesar cada línea de forma individual.

La función de expresiones regulares (regex) es clave en el resaltador de sintaxis. En esta función, utilizamos expresiones regulares para hacer coincidir diferentes patrones, como variables, cadenas de texto, comentarios, números, operadores y palabras clave. Cada vez que se encuentra una coincidencia, se realiza una transformación de la variable al formato HTML correspondiente, aplicando etiquetas y estilos específicos.

Una vez que se ha completado el proceso de resaltado de sintaxis para todas las líneas del archivo, se procede a construir el documento HTML final. Esto implica combinar todas las líneas resaltadas y envolverlas en la estructura HTML adecuada. El resultado final es un archivo HTML que muestra el código fuente resaltado de manera visualmente atractiva y legible.

Un resaltador de sintaxis de este tipo puede tener implicaciones éticas para nuestra sociedad ya que nos permite encontrar cierto tipo de información en un tiempo reducido. Esto puede ser una gran ventaja ya que reduce el tiempo de búsqueda pero tambien puede ser un riesgo. Este tipo de tecnologías se pueden utilizar para restringir contenido e incluso para impulsar contenido específico. Esto se puede usar para esparcir información que perjudique o ayude a individuos.

Consideramos que la disponibilidad de información es una herramienta sumamente importante. Es de esta manera que las personas pueden aprender y educarse confrome aprenden y arman su base de criterios. Por esa razón, la transparencia en los medios es importante, pero cae una gran responsabilidad en las personas en como es esparcida la infromación. Esto lleva a mayores problemáticas como: que tipode información es censorada y que principios son aplicados para tomar estas decisiones.

En resumen, a pesar de la complejidad n^2 de nuestro algoritmo actual, hemos logrado desarrollar un resaltador de sintaxis funcional que puede procesar archivos de Python y resaltar diferentes elementos como variables, cadenas de texto, comentarios, números, operadores y palabras clave. A medida que continuamos mejorando el resaltador de sintaxis, es importante considerar enfoques para optimizar el algoritmo y mejorar su eficiencia, especialmente al trabajar con archivos de gran tamaño.