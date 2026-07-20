# private/

Aquí van los módulos de Odoo hechos a medida para Hidalbe (no OCA, no de
terceros). Cada módulo es una carpeta estándar de Odoo:

```
private/
  hidalbe_algo/
    __init__.py
    __manifest__.py
    models/
    views/
    ...
```

No hace falta declarar nada en `addons.yaml` para que se enlacen: `private`
usa glob `"*"` por defecto (ver `doodbalib.addons_config()`), así que
cualquier módulo válido (con `__manifest__.py`) que pongas aquí se enlaza
solo al reconstruir la imagen.

Recuerda: el `Dockerfile` copia esta carpeta entera a la imagen
(`COPY odoo/custom/src/private/ ...`). Si añades un módulo y no aparece tras
reconstruir, confirma primero que el `git add`/commit realmente lo incluyó.
