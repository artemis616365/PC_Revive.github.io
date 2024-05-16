<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página de Caja</title>
    <!-- Enlaces CSS de Bootstrap y FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Incluir CSS de DataTables -->
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">

    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('img/bg.png');
            background-size: cover;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
        }

        .btn-revisar {
            background-color: blue;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            margin-right: 10px;
        }

        .btn-entrada {
            background-color: green;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
        }

        /* Estilos para las tablas */
        .tabla-registros {
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
        }

        .tabla-registros th,
        .tabla-registros td {
            text-align: center;
            vertical-align: middle;
            padding: 8px;
        }

        .tabla-registros th {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Contenido de la página -->
    <div class="container mt-5">
        <!-- Botones para revisar PCs o registrar entrada -->
        <div class="row mb-3">
            <div class="col">
                <a href="revisar_pc.php" class="btn btn-primary btn-revisar">Revisar PCs</a>
                <a href="insertar_pc.php" class="btn btn-primary btn-entrada">Registrar Entrada</a>
            </div>
        </div>

        <!-- Tabla de registros de PCs -->
        <h2 class="mt-4">Estado de las PCs</h2>
        <table id="myTable" class="table tabla-registros">
            <!-- Encabezado de la tabla -->
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Marca</th>
                    <th>Modelo</th>
                    <th>Procesador</th>
                    <th>RAM</th>
                    <th>Nombre del Cliente</th>
                    <th>Correo</th>
                    <th>Número</th>
                    <th>Fecha de Entrada</th>
                    <th>Fecha de Salida</th>
                    <th>Estado</th>
                    <th>Imprimir</th>
                </tr>
            </thead>
            <!-- Cuerpo de la tabla -->
            <tbody>
                <!-- PHP para mostrar registros de PCs -->
                <?php
                // Incluir el archivo de conexión a la base de datos
                include("conexion.php");

                // Consulta SQL para obtener registros de PCs
                $sql = "SELECT * FROM pc";
                $result = $conexion->query($sql);

                // Mostrar registros en la tabla
                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row['ID'] . "</td>";
                        echo "<td>" . $row['Marca'] . "</td>";
                        echo "<td>" . $row['Modelo'] . "</td>";
                        echo "<td>" . $row['Procesador'] . "</td>";
                        echo "<td>" . $row['RAM'] . "</td>";
                        echo "<td>" . $row['Nombre del Cliente'] . "</td>";
                        echo "<td>" . $row['Correo'] . "</td>";
                        echo "<td>" . $row['Número'] . "</td>";
                        echo "<td>" . $row['Fecha de Entrada'] . "</td>";
                        echo "<td>" . $row['Fecha de Salida'] . "</td>";

                        // Check if the 'Estado' key exists
                        if (isset($row['Estado'])) {
                            echo "<td>" . $row['Estado'] . "</td>";
                        } else {
                            echo "<td>Estado no disponible</td>";
                        }

                        // Agregar un botón para imprimir solo la celda
                        echo "<td><button class='btn btn-info btn-sm' onclick='printCell(this)'>Imprimir</button></td>";

                        echo "</tr>";
                    }
                } else {
                    echo "<tr><td colspan='12'>No se encontraron registros de PCs</td></tr>";
                }

                // Cerrar la resultado
                $result->close();

                // Cerrar la conexión
                $conexion->close();
                ?>
            </tbody>
        </table>
    </div>

    <!-- Enlaces JavaScript de Bootstrap y FontAwesome -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/e979beee93.js" crossorigin="anonymous"></script>

    <!-- Incluir jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Incluir DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function() {
            // Inicializar DataTable
            $('#myTable').DataTable({
                language: {
                    "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Spanish.json"
                }
            });
        });

        function printCell(button) {
            var cellText = button.parentNode.previousElementSibling.innerText;
            var printWindow = window.open('', '_blank');
            printWindow.document.write('<html><head><title>Celda Imprimida</title></head><body><h1>Contenido de la celda:</h1><p>' + cellText + '</p></body></html>');
            printWindow.document.close();
            printWindow.print();
        }
    </script>
</body>
</html>
