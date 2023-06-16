
# Actividad Integradora 5.3: Resaltador de Sintaxis Paralelo
#### Lucía Barrenechea
#### Paula Verdugo
## Descripción de la Evidencia
Desarrollo de un analizador léxico que categoriza y resalta elementos léxicos en código fuente. Generación de documentos HTML para mostrar la estructura léxica. Implementación funcional y análisis de algoritmos. Esta entrega utiliza programación paralela para crear 3 archivos html con 3 archivos de python.

## Instrucciones

Como utilizar el resaltador de syntaxis.

1. Baja el documento syntaxparallel.exs y los ejemplos prueba de python
2. Este programa utiliza 3 archivos python predeterminados. En caso de querer cambiarlos se debe modificar la línea 7,8 y 9.

### Línea de código:
    Syntaxhighlighter.main()

3. Para correrlo en la terminal se necesita escribir:
- iex syntaxparallel.exs

    Con esto el archivo se correrá y aparecerá el archivo HTML llamado "highlighted.html", "thread2.html" y "thread3.html".

## Speedup
### Calculo de tiempo
Para el archivo syntaxparallel.exs se tomaron 3 tomas de tiempo para sacar un promedio. El tiempo aproximado fue 1.25 segundos.
Para el archivo syntaxhighlighter.exs se tomaron 3 tomas de tiempo para sacar un promedio. El tiempo aproximado fue 1.28 segundos.

Es importante considerar que aunque los tiempos son bastante aproximados, el archivo syntaxparallelo realiza 3 veces el codigo en diferentes threads.

### Speedup
Speed up = Tiempo syntaxhighlighter.exs / syntaxparallel.exs

Para el archivo 1: "syntaxparallel.exs" con programación paralela (1.25 segundos) y el archivo 2: "syntaxhighlighter.exs" sin programación paralela (1.28 segundos), podemos calcular el speed up de la siguiente manera:

Speed up = 1.28 / 1.25
Speed up ≈ 1.024

El speed up aproximado es de 1.024. Esto indica que el archivo syntaxparallel.exs, que utiliza programación paralela, es aproximadamente un 2.4% más rápido que el archivo syntaxhighlighter.exs sin programación paralela.

### Calculo de Complejidad
La complejidad de nuestro algoritmo es exponencial debido a que se utiliza una función llamada regex.replace. El uso de esta función ocasiona que la longitud de las líneas utilizadas en el archivo, cada vez que se itera incrementen de tamaño. Esto ocasiona que las cantidad de tiempo que se usa es cada vez mayor mientras incrementan las iteraciones en las líneas.
- La función highlight_line es la encargada de comparar cada renglón para reemplazar aquellas palabras que coinciden con la expresión regular. Entre mas grande es el renglón y más expresiones regulares encuentre, mayor es la complejidad. Aqui es donde se utiliza la función regex.replace por lo que la complejidad de Bigo O es exponencial.

### Conclusión
El cálculo del speed up nos muestra la diferencia de rendimiento entre dos archivos, uno que utiliza programación paralela y otro que no. En este caso, el archivo "syntaxparallel.exs" con programación paralela es aproximadamente un 2.4% más rápido que el archivo "syntaxhighlighter.exs" sin programación paralela. Este resultado nos indica que la implementación de programación paralela en el archivo "syntaxparallel.exs" ha logrado mejorar significativamente su tiempo de ejecución. Tambien se debe considerar que el archivo "syntaxparallel.exs" utilizo 3 diferentes archivos de python y nos dio como resultado 3 archivos html.

La complejidad de algoritmos es de gran improtancia ya que determina que tan eficaz va a ser el archivo para resolver el problema. En nuestro caso, la complejidad de algoritmo es muy mala ya que es exponencial lo que significa que el tiempo crece de forma importante al incrementar el tamaño de los archivos. La función Regex.replace provoca una complejidad exponencial debido al crecimiento en el tamaño de las líneas a medida que se realizan más iteraciones. Esto implica que a medida que aumenta el número de expresiones regulares encontradas y el tamaño de las líneas, el tiempo de ejecución también aumenta de manera significativa.

Es de gran importancia optimizar nuestros algoritmos y utilizar técnicas como la programación paralela para mejorar el rendimiento y reducir el tiempo de ejecución. El análisis de complejidad es fundamental para comprender el impacto de nuestras implementaciones y nos indica cuando es necesario buscar alternativas más eficientes.

Un programa como el que fue realizado nos permitio ubicar información requerida en tan solo unos pocos segundos. El alcance que puede tener el uso de expresiones regulares al igual que la programación paralela es infinito. El uso de multiprocesadores nos permite reducir el tiempo de ejecución de forma importante lo que significa que la busqueda de información puede ser muy eficiente. Esta tecnología tiene muchas ventajas ya que nos puede ayudar a encontrar información relevante de forma rapida y eficiente. Esto se puede utilizar para la educación brindando herramientas para el rapido aprendizaje. Sin embargo, esta tecnología se puede explotar para sacar provecho a información importante. Ta bien se puede utilizar para encontrar un público especifico, censorar información e incluso para exparcir información falsa. Es necesario entender las repercusiones eticas que este tipo de tecnología puede llegar a tener en nuestra sociedad.



