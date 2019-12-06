{% extends '../layouts/app.volt' %}

{% block content %}
<div class="d-flex justify-content-between">
    <h1 class="h3 mb-2 text-gray-800">Daftar Barang Stok Menipis</h1>
</div>
<hr>
<div class="card shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="minimal-table" width="100%" cellspacing="0">
                <div class="alert alert-danger" style="display:none"></div>
                <div class="alert alert-success" style="display:none"></div>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Brand</th>
                        <th>Nama</th>
                        <th>Jenis</th>
                        <th>Volume</th>
                        <th>Stok</th>
                        <th>Stok Minimal</th>
                    </tr>
                </thead>
                <tbody>
    
                </tbody>
            </table>
        </div>
    </div>
</div>
{% endblock %}

{% block js %}
<script type="text/javascript">
    let table = 
    $('#minimal-table').DataTable({
        order: [[0, 'desc']],
        processing: true,
        serverSide: true,
        ajax: "{{ url('/filter/minimal') }}",
        columns: [
            {data: 'id', render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            } },
            {data: 'brand_id', name: 'brand_id'},
            {data: 'name', name: 'name'},
            {data: 'type', name: 'type'},
            {data: 'volume', name: 'volume'},
            {data: 'stock', name: 'stock'},
            {data: 'min_stock', name: 'min_stock'}
        ]
    });
</script>

{% endblock %}