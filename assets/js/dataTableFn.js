/*Ver video https://www.youtube.com/watch?v=QSoubKcjqo8
y luego 
https://datatables.net/manual/data/
*/

$(function () {
  // Handler for .ready() called.

  //nombre producto, stock, precio real, precio oferta
  let data = [{
      nombre: 'Producto  1',
      descripcion: 'lorem ipsu producto 1',
      stock: 100,
      precio_real: 11000,
      precio_oferta: 10000,
    },
    {
      nombre: 'Producto  2',
      descripcion: 'lorem ipsu producto 2',
      stock: 200,
      precio_real: 22000,
      precio_oferta: 20000,
    },
    {
      nombre: 'Producto  3',
      descripcion: 'lorem ipsu producto 3',
      stock: 300,
      precio_real: 33000,
      precio_oferta: 30000,
    },
    {
      nombre: 'Producto  4',
      descripcion: 'lorem ipsu producto 4',
      stock: 400,
      precio_real: 44000,
      precio_oferta: 40000,
    },
    {
      nombre: 'Producto  5',
      descripcion: 'lorem ipsu producto 5',
      stock: 500,
      precio_real: 55000,
      precio_oferta: 50000,
    },
    {
      nombre: 'Producto  6',
      descripcion: 'lorem ipsu producto 6',
      stock: 600,
      precio_real: 66000,
      precio_oferta: 60000,
    },
    {
      nombre: 'Producto  7',
      descripcion: 'lorem ipsu producto 7',
      stock: 700,
      precio_real: 77000,
      precio_oferta: 7000,
    },
    {
      nombre: 'Producto  8',
      descripcion: 'lorem ipsu producto 8',
      stock: 800,
      precio_real: 88000,
      precio_oferta: 80000,
    },
    {
      nombre: 'Producto  9',
      descripcion: 'lorem ipsu producto 9',
      stock: 0,
      precio_real: 99000,
      precio_oferta: 90000,
    },
    {
      nombre: 'Producto 10',
      descripcion: 'lorem ipsu producto 10',
      stock: 0,
      precio_real: 100000,
      precio_oferta: 90000,
    },
    {
      nombre: 'Producto 11',
      descripcion: 'lorem ipsu producto 11',
      stock: 0,
      precio_real: 1100000,
      precio_oferta: 100000,
    },
    {
      nombre: 'Producto 12',
      descripcion: 'lorem ipsu producto 12',
      stock: 0,
      precio_real: 1200000,
      precio_oferta: 100000,
    },
    {
      nombre: 'Producto 13',
      descripcion: 'lorem ipsu producto 13',
      stock: 0,
      precio_real: 1300000,
      precio_oferta: 100000,
    },
    {
      nombre: 'Producto 14',
      descripcion: 'lorem ipsu producto 14',
      stock: 0,
      precio_real: 1400000,
      precio_oferta: 100000,
    },
    {
      nombre: 'Producto 15',
      descripcion: 'lorem ipsu producto 15',
      stock: 0,
      precio_real: 1500000,
      precio_oferta: 100000,
    },
       {
      nombre: 'Producto 16',
      descripcion: 'lorem ipsu producto 16',
      stock: 0,
      precio_real: 1600000,
      precio_oferta: 100000,
    },
    {
      nombre: 'Producto 17',
      descripcion: 'lorem ipsu producto 17',
      stock: 0,
      precio_real: 1700000,
      precio_oferta: 100000,
    },
    {
      nombre: 'Producto 18',
      descripcion: 'lorem ipsu producto 18',
      stock: 0,
      precio_real: 1800000,
      precio_oferta: 100000,
    },
  ]

  //
  $('#myTable').DataTable({
    responsive: true,
    //para cambiar el lenguaje a español
    "language": {
      "lengthMenu": "Mostrar _MENU_ registros",
      "zeroRecords": "No se encontraron resultados",
      "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
      "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
      "infoFiltered": "(filtrado de un total de _MAX_ registros)",
      "sSearch": "Buscar:",
      "oPaginate": {
        "sFirst": "Primero",
        "sLast": "Último",
        "sNext": "Siguiente",
        "sPrevious": "Anterior",
      },
      "sProcessing": "Procesando...",
    },
    //indicamos donde estan los datos, podria escribir solo data, 
    data: data,
    //indicamos las columnas que mostraremos, en este caso son todas pero pordria decidir por solo algunas
    columns: [{
        title: 'Nombre',
        data: 'nombre'
      },
      {
        title: 'Descripción',
        data: 'descripcion'
      },
      {
        title: 'Stock',
        data: 'stock',
        //alineamos el texto a la derecha
        className: 'dt-right',
        //este data se refiere a la celda, ese lo tomamos y lo transformamos
        render: (data, type, row) => new Intl.NumberFormat('cl').format(data),
      },
      {
        title: 'Precio Real',
        data: 'precio_real',
        className: 'dt-right',
        //este data se refiere a la celda, ese lo tomamos y lo transformamos
        render: (data, type, row) => '$ ' + new Intl.NumberFormat('cl').format(data),
      },
      {
        title: 'Precio Oferta',
        data: 'precio_oferta',
        className: 'dt-right',
        //este data se refiere a la celda, ese lo tomamos y lo transformamos
        render: (data, type, row) => new Intl.NumberFormat('cl').format(data),
      }
    ]
  });


});