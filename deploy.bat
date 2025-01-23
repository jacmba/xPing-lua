@echo Deploying xPing to X-Plane...
@echo X-Plane found at %xplane%
set destination="%xplane%\Resources\plugins\FlyWithLua\Scripts"
set modules="%xplane%\Resources\plugins\FlyWithLua\Modules"

copy /Y src\* %destination%\
xcopy /e /Y src\modules\ %modules%\

@echo Copied xPing to %destination%