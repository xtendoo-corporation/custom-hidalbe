FROM tecnativa/doodba:19.0

# Repos propios del proyecto (OCA + Odoo/OCB), copiados ANTES del build para
# que 100-repos-aggregate use este repos.yaml en vez de autogenerar uno con
# DEFAULT_REPO_PATTERN_ODOO/DEFAULT_REPO_PATTERN.
COPY odoo/custom/src/repos.yaml /opt/odoo/custom/src/repos.yaml
COPY odoo/custom/src/addons.yaml /opt/odoo/custom/src/addons.yaml
COPY odoo/custom/dependencies/ /opt/odoo/custom/dependencies/
# Módulos propios (a medida para Hidalbe). doodbalib enlaza automáticamente
# todo lo que haya aquí (PRIVATE usa glob "*" por defecto, no requiere
# entrada en addons.yaml) — pero solo si el código llega a la imagen.
COPY odoo/custom/src/private/ /opt/odoo/custom/src/private/

RUN groupadd -g 1001 odoo && \
    useradd -u 1001 -g odoo -d /home/odoo -m -s /bin/bash odoo && \
    mkdir -p /home/odoo/.ssh

RUN sed -i 's/^export UID=0 GID=\$GID UMASK=0027$/export GID=\$GID UMASK=0027/' \
    /opt/odoo/common/build.d/100-repos-aggregate

ENV SHELL=/bin/bash \
    AGGREGATE=true \
    PIP_INSTALL_ODOO=true \
    DB_VERSION=16 \
    ODOO_VERSION=19.0

RUN /opt/odoo/common/build

ENTRYPOINT ["/opt/odoo/common/entrypoint"]
