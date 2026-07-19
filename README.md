# custom-hidalbe

Proyecto Doodba (Odoo 19.0) para el cliente Hidalbe Instalaciones.

Desplegado sobre Kubernetes (k3s) en `162.19.79.108`, namespace
`hidalbe-electricidad`. Ver la skill `odoo-kubernetes` (en
`xtendoo-corporation/calude-skills`) para el flujo de build y despliegue, y
`odoo-kubernetes/references/repos-and-addons.md` para cómo añadir repos OCA,
PRs, librerías, o refrescar el código fuente.

## Estructura

```
Dockerfile                       # build de la imagen Doodba
odoo/custom/src/repos.yaml       # qué repos se clonan (git-aggregator)
odoo/custom/src/addons.yaml      # qué addons de esos repos se enlazan
odoo/custom/dependencies/        # dependencias pip/apt/npm adicionales
```

## Build y despliegue

```bash
docker build -t 162.19.79.108:5000/hidalbe-electricidad/odoo:19.0-<fecha> .
docker push 162.19.79.108:5000/hidalbe-electricidad/odoo:19.0-<fecha>
kubectl set image deployment/odoo odoo=162.19.79.108:5000/hidalbe-electricidad/odoo:19.0-<fecha> -n hidalbe-electricidad
kubectl rollout status deployment/odoo -n hidalbe-electricidad
```
