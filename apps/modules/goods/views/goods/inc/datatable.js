let table = 
$('#goods-table').DataTable({
    order: [[0, 'desc']], 
    processing: true,
    serverSide: true,
    ajax: "{{ url('goods') }}",   
    columns: [
        {data: 'id', render: function (data, type, row, meta) {
            return meta.row + meta.settings._iDisplayStart + 1;
        } },
        {data: 'brand_id', name: 'brand_id'},
        {data: 'name', name: 'name'},
        {data: 'type', name: 'type'},
        {data: 'volume', name: 'volume'},
        {data: 'stock', name: 'stock'},
        {data: 'min_stock', name: 'min_stock'},
        {data: 'last_purchase_price', name: 'last_purchase_price'},
        {data: 'updated_at', name: 'updated_at'}
    ],
    columnDefs: [{
        targets: [9],
        "render": function (data, type, row, meta) {
            return  '<div class="text-center">'+
                        '<a onclick="inflowGoods('+ row.id +')" class="btn btn-success btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Tambah Stok"><i class="fas fa-plus fa-2x text-white"></i></a> '+
                        '<a onclick="outflowGoods('+ row.id +')" class="btn btn-success btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Kurangi Stok"><i class="fas fa-minus fa-2x text-white"></i></a> '+
                        '<a onclick="editGoods('+ row.id +')" class="btn btn-info btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Edit Barang"><i class="fas fa-edit text-white"></i></a> ' +
                        '<a onclick="deleteGoods('+ row.id +')" class="btn btn-danger btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Hapus Barang"><i class="fas fa-trash text-white"></i></a>'+
                    '</div>';
        }
    }]
});