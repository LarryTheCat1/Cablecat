<style>
    label.required:after {
        content: '*';
        color: red;
    }
</style>

<div class='row'>
    <form name='newCable' method='post' class='form form-horizontal'>
        <input type='hidden' name='index' value='$index'/>
        <input type='hidden' name='ID' value='$FORM{chg}'/>
        <input type='hidden' name='operation_type' value='%OPERATION_TYPE%'>

        <div class='panel panel-primary panel-form'>
            <div class='panel-heading'>%BTN_NAME% $_CABLE $_TYPE</div>
            <div class='panel-body'>
                <div class='form-group'>
                    <label class='control-label col-md-3 required'>$_NAME</label>

                    <div class='col-md-9'>
                        <input type='text' class='form-control' required aria-required='true' name='NAME'
                               value='%NAME%'/>
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-5'>$_MODULES_COUNT</label>

                    <div class='col-md-7'>
                        <input type='number' value='%MODULES_COUNT%' class='form-control' name='MODULES_COUNT'/>
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-5'>$_FIBERS_COUNT</label>

                    <div class='col-md-7'>
                        <input type='number' value='%FIBERS_COUNT%' class='form-control' name='FIBERS_COUNT'/>
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-5'>$_COLOR_SCHEME</label>

                    <div class='col-md-7'>
                        %COLOR_SCHEME%
                    </div>
                </div>

            </div>
            <div class='panel-footer text-center'>
                <a class='btn btn-default btn-sm' href='?%CANCEL_BTN_HREF%'>$_CANCEL</a>
                <button class='btn btn-primary' type='submit'>%BTN_NAME%</button>
            </div>
        </div>
    </form>
</div>
