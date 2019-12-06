<div class="modal fade" id="modal-form">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" class="form-horizontal" data-toggle="validator">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title font-weight-bold"></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    
                    <!-- Modal body -->
                    <div class="modal-body">
                        <input type="hidden" id="id" name="id">
                        <input type="hidden" id="goods_id" name="goods_id">
    
                        <div id="info">
                            <div class="form-group row">
                                <label for="name_info" class="col-md-5 text-md-right">Nama</label>
        
                                <div class="col-md-7">
                                    <div id="name_info"></div>
                                </div>
                            </div>
        
                            <div class="form-group row">
                                <label for="purchase_info" class="col-md-5 text-md-right">Harga Beli Terakhir</label>
        
                                <div class="col-md-7">
                                    <div id="purchase_info"></div>
                                </div>
                            </div>
        
                            <div class="form-group row">
                                <label for="volume_info" class="col-md-5 text-md-right">Volume</label>
        
                                <div class="col-md-7">
                                    <div id="volume_info"></div>
                                </div>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="variant" class="col-md-5 col-form-label text-md-right">Variant Barang(ml)</label>
    
                            <div class="col-md-7">
                                <input id="variant" type="text" class="square form-control" name="variant" required autofocus>
                                
                                <span class="text-danger">
                                    <small id="variant-error"></small>
                                </span>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="modal" class="col-md-5 col-form-label text-md-right">Harga Modal</label>
    
                            <div class="col-md-7">
                                <input id="modal" type="text" class="square form-control" name="modal" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="package" class="col-md-5 col-form-label text-md-right">Biaya Pemaketan</label>
    
                            <div class="col-md-7">
                                <input id="package" type="text" class="square form-control" name="package" required>
                                
                                <span class="text-danger">
                                    <small id="package-error"></small>
                                </span>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="hpp" class="col-md-5 col-form-label text-md-right">HPP</label>
    
                            <div class="col-md-7">
                                <input id="hpp" type="text" class="square form-control " name="hpp" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="normal_profit" class="col-md-5 col-form-label text-md-right">Keuntungan Normal</label>
    
                            <div class="col-md-7">
                                <input id="normal_profit" type="text" class="square form-control " name="normal_profit" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="normal_price" class="col-md-5 col-form-label text-md-right">Harga Normal</label>
    
                            <div class="col-md-7">
                                <input id="normal_price" type="text" class="square form-control " name="normal_price" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="market_price" class="col-md-5 col-form-label text-md-right">Harga Pasar</label>
    
                            <div class="col-md-7">
                                <input id="market_price" type="text" class="square form-control " name="market_price">
                                
                                <span class="text-danger">
                                    <small id="market_price-error"></small>
                                </span>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="recommend_price" class="col-md-5 col-form-label text-md-right">Harga Rekomendasi</label>
    
                            <div class="col-md-7">
                                <input id="recommend_price" type="text" class="square form-control " name="recommend_price" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="profit" class="col-md-5 col-form-label text-md-right">Keuntungan</label>
    
                            <div class="col-md-7">
                                <input id="profit" type="text" class="square form-control " name="profit" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="last_price" class="col-md-5 col-form-label text-md-right">Harga Akhir</label>
    
                            <div class="col-md-7">
                                <input id="last_price" type="text" class="square form-control " name="last_price"  required>
                                
                                <span class="text-danger">
                                    <small id="last_price-error"></small>
                                </span>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="last_profit" class="col-md-5 col-form-label text-md-right">Keuntungan Akhir</label>
    
                            <div class="col-md-7">
                                <input id="last_profit" type="text" class="square form-control " name="last_profit" required readonly>
    
                                <small class="help-block with-errors text-danger"></small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="col-md-9 offset-md-3">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                Kembali
                            </button>
                            <button type="button" class="btn btn-primary" id="form-submit">
                                Submit
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>