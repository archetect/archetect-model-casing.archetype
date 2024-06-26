# Archetect Model Casing

This is an [Archetect](https://archetect.github.io/) archetype.

## Rendering

To generate content from this Archetype, copy and execute the following command:

```sh
  archetect render https://github.com/archetect/archetect-model-casing.archetype.git
```

## Usage

This archetype expands cases for sets of applications and models. It is intended to be used as a component library
for parent archetypes to expand model casing such that pre-expanded models do not have to be supplied to archetypes
that required a strongly-cased model.

With a YAML answer file `answers.yaml` containing one or more application sets and/or a model:

```yaml
applications:
  catalog-service:
    prefix: catalog
    suffix: service
    lang: rust
    transport: grpc
    model:
      entities:
        catalog:
          name: catalog
          fields:
            id:
              name: id
              type: ID
            content:
              name: content
              type: String
model:
  entities:
    cart:
      name: cart
      fields:
        id:
          name: id
          type: ID
        first_name:
          name: first_name
          type: String
        last_name:
          name: last_name
          type: String
        middle_name:
          name: middle_name
          type: String
          optional: true
        aliases:
          name: aliases
          type: String
          optional: true
          repeated: true
```

Running the following archetect command:

```shell
archetect render https://github.com/archetect/archetect-model-casing.archetype.git -A answer.yaml -s debug-context 
```

Would result in the following output:

```yaml
applications:
  catalog-service:
    PROJECT_NAME: CATALOG_SERVICE
    PROJECT_PREFIX: CATALOG
    PROJECT_SUFFIX: SERVICE
    ProjectName: CatalogService
    ProjectPrefix: Catalog
    ProjectSuffix: Service
    lang: rust
    model:
      entities:
        catalog:
          ENTITY_NAME: CATALOG
          EntityName: Catalog
          entity-name: catalog
          entity-title: Catalog
          entityName: catalog
          entity_name: catalog
          fields:
            content:
              FIELD_NAME: CONTENT
              FieldName: Content
              field-name: content
              field-title: Content
              fieldName: content
              field_name: content
              name: content
              type: String
            id:
              FIELD_NAME: ID
              FieldName: Id
              field-name: id
              field-title: Id
              fieldName: id
              field_name: id
              name: id
              pk: true
              type: ID
          name: catalog
    prefix: catalog
    project-name: catalog-service
    project-prefix: catalog
    project-suffix: service
    project-title: Catalog Service
    projectName: catalogService
    projectPrefix: catalog
    projectSuffix: service
    project_name: catalog_service
    project_prefix: catalog
    project_suffix: service
    suffix: service
    transport: grpc
model:
  entities:
    cart:
      ENTITY_NAME: CART
      EntityName: Cart
      entity-name: cart
      entity-title: Cart
      entityName: cart
      entity_name: cart
      fields:
        aliases:
          FIELD_NAME: ALIASES
          FieldName: Aliases
          field-name: aliases
          field-title: Aliases
          fieldName: aliases
          field_name: aliases
          name: aliases
          optional: true
          repeated: true
          type: String
        first_name:
          FIELD_NAME: FIRST_NAME
          FieldName: FirstName
          field-name: first-name
          field-title: First Name
          fieldName: firstName
          field_name: first_name
          name: first_name
          type: String
        id:
          FIELD_NAME: ID
          FieldName: Id
          field-name: id
          field-title: Id
          fieldName: id
          field_name: id
          name: id
          pk: true
          type: ID
        last_name:
          FIELD_NAME: LAST_NAME
          FieldName: LastName
          field-name: last-name
          field-title: Last Name
          fieldName: lastName
          field_name: last_name
          name: last_name
          type: String
        middle_name:
          FIELD_NAME: MIDDLE_NAME
          FieldName: MiddleName
          field-name: middle-name
          field-title: Middle Name
          fieldName: middleName
          field_name: middle_name
          name: middle_name
          optional: true
          repeated: true
          type: String
      name: cart
```

### Default Models

This archetype may also take an optional `default_model` in the form of a String or List of strings, and a basic model 
will be generated.  This allows an archetype to call this archetype as a library, and either case a model passed to the parent,
or case a generic default model instead.