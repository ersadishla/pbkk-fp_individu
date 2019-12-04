{% extends '../layouts/app.volt' %}

{% block content %}
<div class="d-flex justify-content-between">
    <h1 class="h3 mb-2 text-gray-800">Daftar Barang</h1>
</div>
<hr>
<div class="card shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="goods-table" cellspacing="0" width="100%">
                <div class="alert alert-danger" style="display:none"></div>
                <div class="alert alert-success" style="display:none"></div>
                <div class="d-flex justify-content-end">
                    <a href="#" onclick="addGoods()" class="btn btn-primary">
                        Tambah
                    </a>
                </div>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Brand</th>
                        <th>Nama</th>
                        <th>Jenis</th>
                        <th>Volume</th>
                        <th>Stok</th>
                        <th>Stok Minimal</th>
                        <th>Harga Beli</th>
                        <th width="10rem">Tanggal Stok</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
    
                </tbody>
            </table>
        </div>
    </div>
</div>

{% include '/views/goods/inc/crud.volt' %}

{% include '/views/goods/inc/flow.volt' %}

{% endblock %}

{% block js %}

<script>
    $('.select2').select2({
        theme: "bootstrap",
        placeholder: 'Pilih salah satu',
        allowClear: true
    });

    {% include '/views/goods/inc/datatable.js' %}

    {% include '/views/goods/inc/crud.js' %}

    {% include '/views/goods/inc/flow.js' %}

</script>

{% endblock %}