<div class='row'>
    <form name='newCable' method='post' class='form form-horizontal'>
        <input type='hidden' name='index' value='$index'>
        <input type='hidden' name='ID' value='$FORM{chg}'>
        <input type='hidden' name='operation_type' value='%OPERATION_TYPE%'>
        <div class='panel panel-primary panel-form'>
            <div class='panel-heading'>%BTN_NAME% $_CABLE_BIGHTS</div>
            <div class='panel-body'>
                <div class='form-group'>
                    <label class='control-label col-md-4'>$_CABLE $_TYPE</label>

                    <div class='col-md-8'>
                        %CABLE_TYPE%
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-4'>$_METERS_IN_BIGHT</label>

                    <div class='col-md-8'>
                        <input type='number' class='form-control' name='METERS'/>
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
