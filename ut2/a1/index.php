<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculadora en PHP</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        form {
            max-width: 300px;
            margin: auto;
        }
        input, select, button {
            width: 100%;
            margin: 5px 0;
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h1>Calculadora Dockerizada</h1>
    <form method="POST" action="">
        <label for="num1">Número 1:</label>
        <input type="number" name="num1" id="num1" step="any" required>

        <label for="num2">Número 2:</label>
        <input type="number" name="num2" id="num2" step="any" required>

        <label for="operation">Operación:</label>
        <select name="operation" id="operation" required>
            <option value="add">Suma</option>
            <option value="subtract">Resta</option>
            <option value="multiply">Multiplicación</option>
            <option value="divide">División</option>
        </select>
        <img src="calculadora.png" alt="Imagen calculadora">
        <button type="submit">Calcular</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Obtener los valores del formulario
        $num1 = $_POST['num1'];
        $num2 = $_POST['num2'];
        $operation = $_POST['operation'];
        $result = null;

        // Validar y realizar la operación
        switch ($operation) {
            case "add":
                $result = $num1 + $num2;
                break;
            case "subtract":
                $result = $num1 - $num2;
                break;
            case "multiply":
                $result = $num1 * $num2;
                break;
            case "divide":
                if ($num2 != 0) {
                    $result = $num1 / $num2;
                } else {
                    $result = "Error: División por cero no permitida.";
                }
                break;
            default:
                $result = "Operación no válida.";
        }

        // Mostrar el resultado
        echo "<h2>Resultado:</h2>";
        echo "<p>" . htmlspecialchars($result) . "</p>";
    }
    ?>
</body>
</html>
