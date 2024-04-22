let context = #{};

const CASE_STRATEGY = CasedIdentityCasedValue(PROGRAMMING_CASES);

if ANSWERS.applications != () {
    context.applications = case_applications(ANSWERS.applications);
}

if type_of(ANSWERS.model) == "map" {
    context.model = case_model(ANSWERS.model);
} else if ANSWERS.default_model != () {
    let model = generate_model(ANSWERS.default_model);
    if type_of(model) == "map" {
        context.model = case_model(model);
    }
}

fn case_applications(applications) {
    for application_key in applications.keys() {
        applications[application_key] = case_application(applications[application_key]);
    }
    applications
}

fn case_application(application) {
    let prefix = application["prefix"];
    let suffix = application["suffix"];
    if prefix != () {
        application += set("project-prefix", prefix, #{
            cases: [
                global::CASE_STRATEGY,
            ],
        });
    }
    if suffix != () {
        application += set("project-suffix", suffix, #{
            cases: [
                global::CASE_STRATEGY,
            ],
        });
    }

    if prefix != () && suffix != () {
        application += set("project-name", `${prefix}-${suffix}`, #{
            cases: [
               global::CASE_STRATEGY,
               FixedKeyCasedValue("project-title", TitleCase),
            ],
        });
    }
    let model = application.model;
    if model != () {
        application.model = case_model(model);
    }
    application
}

fn case_model(model) {
    for entity_key in model.entities.keys() {
        model.entities[entity_key] = case_entity(model.entities[entity_key]);
    }
    model
}

fn case_entity(entity) {
    if entity != () {
        let name = entity["name"];
        if name != () {
            entity += set("entity-name", name, #{
                cases: [
                    global::CASE_STRATEGY,
                    FixedKeyCasedValue("entity-title", TitleCase),
                ],
            });
            for field_key in entity.fields.keys() {
                entity.fields.set(field_key, case_field(entity.fields[field_key]));
            }
        }
    }
    entity
}

fn case_field(field) {
    if field != () {
        let name = field["name"];
        field += set("field-name", name, #{
            cases: [
                global::CASE_STRATEGY,
                FixedKeyCasedValue("field-title", TitleCase),
            ],
        });
    }
    field
}

fn generate_model(model) {
    if type_of(model) == "list" {
        let entities = #{};

        for entity_key in model {
            entities[entity_key] = generate_entity(entity_key);
        }

        return #{
            "entities": entities,
        };
    }

    if type_of(model) == "string" {
        let entities = #{};
        let entity_key = model;
        entities[entity_key] = generate_entity(entity_key);

        return #{
            "entities": entities,
        }
    }
}

fn generate_entity(name) {
    let entity = #{
        name: name,
        fields: #{
            contents: #{
                name: "contents",
                type: "String",
                required: true,
            },
        },
    };
    entity
}

if switch_enabled("debug-context") {
    display(as_yaml(context));
}

// Return Context
context