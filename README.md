# Proyecto: Actualización automática de Fecha de Resolución en SupportRequest__c

## Descripción

Este proyecto implementa:

- Clase Apex `SupportRequestManualUpdateController` para recalcular la fecha de resolución esperada.
- Componente LWC `updateExpectedDate` que ejecuta la actualización automáticamente al cargar la página de un registro `SupportRequest__c`.
- Clase de test para garantizar cobertura y correcto funcionamiento.

---

## Opciones para probar la solución

### Opción 1: Acceso a Playground con todo subido

- URL: [https://cunning-narwhal-rwwj1z-dev-ed.trailblaze.lightning.force.com/](https://cunning-narwhal-rwwj1z-dev-ed.trailblaze.lightning.force.com/)
- Usuario: tomasmorenoalonso@cunning-narwhal-rwwj1z.com
- Contraseña: Clarcat_2024

**Pasos:**

1. Entrar al playground con el usuario.
2. Abrir cualquier registro de SupportRequest__c.
3. El componente `updateExpectedDate` actualizará automáticamente la fecha esperada si procede.
4. Verifica mediante mensaje Toast el resultado.

---

### Opción 2: Despliegue en tu Playground

1. Clona este repositorio o descarga el código.
2. Asegúrate de tener [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli) instalado y autenticado.
3. En la terminal, dentro del proyecto, ejecuta:

```bash
sfdx force:source:deploy -x manifest/package.xml -u YOUR_PLAYGROUND_ALIAS
