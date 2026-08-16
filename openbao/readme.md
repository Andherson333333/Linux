# OpenBao — ¿Qué es y para qué sirve?

OpenBao es un fork 100% open source (Apache 2.0) de HashiCorp Vault,
mantenido por la Linux Foundation. Gestiona secretos de forma
centralizada: contraseñas, llaves, certificados y tokens dejan de vivir
fijos en scripts, archivos de config o repositorios, y en su lugar se
piden a OpenBao en el momento que se necesitan.

Principio central: **nada queda válido para siempre**. Todo tiene TTL
(tiempo de vida) o límite de uso, y se revoca automáticamente.

---

## Capacidades principales

### 1. Almacenamiento de secretos estáticos (KV)
Guarda pares clave-valor cifrados (contraseñas, API keys, tokens de
terceros). Reemplaza archivos `.env` o secretos hardcodeados en scripts.
Con versionado — puedes ver y restaurar valores anteriores.

### 2. Credenciales dinámicas de bases de datos
Genera usuarios reales y temporales directamente en Postgres, MySQL,
MongoDB, etc., con permisos definidos de antemano. Al vencer el TTL, el
usuario se borra solo de la base de datos — sin contraseñas fijas
compartidas entre aplicaciones o personas.

### 3. SSH con certificados firmados
Reemplaza llaves SSH estáticas (`authorized_keys`) por certificados de
corta duración firmados por una CA interna. Los servidores solo
necesitan confiar en la CA una vez — no hace falta distribuir ni
revocar llaves individuales por servidor.

### 4. Motor de Kubernetes
Genera ServiceAccounts y tokens temporales en un cluster real, con
permisos RBAC acotados. Sirve para dar acceso puntual a un cluster sin
repartir kubeconfigs permanentes.

### 5. PKI interno (Certificate Authority)
Actúa como tu propia CA — emite certificados TLS internos bajo demanda,
con expiración automática. Útil para mTLS entre servicios o
certificados de corta vida para infraestructura interna.

### 6. Encryption as a Service (Transit)
Cifra y descifra datos sin que la aplicación tenga que manejar ni
almacenar las claves de cifrado — OpenBao hace el trabajo criptográfico,
la clave nunca sale de su almacenamiento.

### 7. AppRole (autenticación de máquinas/scripts)
Permite que scripts y aplicaciones se autentiquen sin tener un token fijo
guardado. Usa un `role_id` (no sensible) + `secret_id` (temporal, de un
solo uso o con TTL corto), evitando dejar credenciales estáticas en
código o pipelines de CI/CD.

### 8. OIDC Provider
OpenBao puede actuar como proveedor de identidad (tipo "Okta interno")
para aplicaciones que hablan OIDC/OAuth2 nativo (Grafana, ArgoCD, apps
propias), centralizando el login sin que cada herramienta tenga su
propio sistema de usuarios.

### 9. Políticas de mínimo privilegio
Cada token/usuario recibe exactamente los permisos que necesita, sobre
rutas específicas — nunca acceso total por defecto. El root token se usa
solo para configuración inicial, nunca para operación diaria.

### 10. Audit logging
Registra cada operación (quién pidió qué, cuándo, desde dónde) —
esencial para cumplimiento y para investigar incidentes.

---

## Lo que NO controla (autorización vs. autenticación)

OpenBao decide **quién puede autenticarse y con qué credenciales
temporales** — pero **no controla qué hace esa persona una vez
adentro** del sistema destino. Ejemplos:

- En SSH: OpenBao firma el certificado, pero `sudoers` en el servidor
  destino sigue decidiendo qué comandos puede correr ese usuario.
- En Kubernetes: OpenBao genera el token, pero el RBAC del cluster
  decide qué puede hacer ese ServiceAccount.
- En bases de datos: OpenBao crea el usuario con los permisos que tú
  definiste en el `role` — esos permisos los aplica el motor de la base
  de datos, no OpenBao.

---

## Casos de uso típicos

| Problema | Solución con OpenBao |
|---|---|
| Contraseña de DB hardcodeada en un script | AppRole + KV o Database Secrets Engine |
| Compartir kubeconfig permanente con el equipo | Kubernetes Secrets Engine |
| Llave SSH compartida entre varias personas | SSH Secrets Engine (certificados firmados) |
| Cada app con su propio login | OIDC Provider |
| Rotar contraseñas de servicio manualmente | Credenciales dinámicas con TTL |
| Saber quién accedió a qué y cuándo | Audit logging |

---

## Recursos

- Sitio oficial: https://openbao.org
- Documentación: https://openbao.org/docs
- Repositorio: https://github.com/openbao/openbao
