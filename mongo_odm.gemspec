# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongo_odm}
  s.version = "0.2.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carlos Paramio"]
  s.date = %q{2011-04-11}
  s.description = %q{mongo_odm is a flexible persistence module for any Ruby class to MongoDB.}
  s.email = %q{carlos@evolve.st}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "CONTRIBUTORS",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "lib/mongo_odm.rb",
    "lib/mongo_odm/collection.rb",
    "lib/mongo_odm/config.rb",
    "lib/mongo_odm/core_ext/conversions.rb",
    "lib/mongo_odm/core_ext/hash_recursive_merge.rb",
    "lib/mongo_odm/criteria.rb",
    "lib/mongo_odm/cursor.rb",
    "lib/mongo_odm/document.rb",
    "lib/mongo_odm/document/attribute_methods.rb",
    "lib/mongo_odm/document/attribute_methods/dirty.rb",
    "lib/mongo_odm/document/attribute_methods/inspect.rb",
    "lib/mongo_odm/document/attribute_methods/localization.rb",
    "lib/mongo_odm/document/attribute_methods/query.rb",
    "lib/mongo_odm/document/attribute_methods/read.rb",
    "lib/mongo_odm/document/attribute_methods/write.rb",
    "lib/mongo_odm/document/callbacks.rb",
    "lib/mongo_odm/document/equality.rb",
    "lib/mongo_odm/document/fields.rb",
    "lib/mongo_odm/document/finders.rb",
    "lib/mongo_odm/document/indexes.rb",
    "lib/mongo_odm/document/inspect.rb",
    "lib/mongo_odm/document/persistence.rb",
    "lib/mongo_odm/document/referable.rb",
    "lib/mongo_odm/document/timestamps.rb",
    "lib/mongo_odm/document/validations.rb",
    "lib/mongo_odm/document/validations/uniqueness_validator.rb",
    "lib/mongo_odm/errors.rb",
    "lib/mongo_odm/railtie.rb",
    "lib/mongo_odm/railties/database.rake",
    "lib/mongo_odm/reference.rb",
    "lib/mongo_odm/version.rb",
    "spec/models/00-blank_slate.rb",
    "spec/models/01-shape.rb",
    "spec/models/02-circle.rb",
    "spec/models/03-big_red_circle.rb",
    "spec/mongo_odm/collection_spec.rb",
    "spec/mongo_odm/config_spec.rb",
    "spec/mongo_odm/core_ext/conversions_spec.rb",
    "spec/mongo_odm/criteria_spec.rb",
    "spec/mongo_odm/cursor_spec.rb",
    "spec/mongo_odm/document/attribute_methods/dirty_spec.rb",
    "spec/mongo_odm/document/attribute_methods/localization_spec.rb",
    "spec/mongo_odm/document/attribute_methods/query_spec.rb",
    "spec/mongo_odm/document/attribute_methods/read_spec.rb",
    "spec/mongo_odm/document/attribute_methods/write_spec.rb",
    "spec/mongo_odm/document/attribute_methods_spec.rb",
    "spec/mongo_odm/document/callbacks_spec.rb",
    "spec/mongo_odm/document/fields_spec.rb",
    "spec/mongo_odm/document/finders_spec.rb",
    "spec/mongo_odm/document/inspect_spec.rb",
    "spec/mongo_odm/document/persistence_spec.rb",
    "spec/mongo_odm/document/referable_spec.rb",
    "spec/mongo_odm/document/timestamps_spec.rb",
    "spec/mongo_odm/document/validations_spec.rb",
    "spec/mongo_odm/document_spec.rb",
    "spec/mongo_odm/mongo_odm_spec.rb",
    "spec/mongo_odm/reference_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/carlosparamio/mongo_odm}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{mongo_odm is a flexible persistence module for any Ruby class to MongoDB.}
  s.test_files = [
    "spec/models/00-blank_slate.rb",
    "spec/models/01-shape.rb",
    "spec/models/02-circle.rb",
    "spec/models/03-big_red_circle.rb",
    "spec/mongo_odm/collection_spec.rb",
    "spec/mongo_odm/config_spec.rb",
    "spec/mongo_odm/core_ext/conversions_spec.rb",
    "spec/mongo_odm/criteria_spec.rb",
    "spec/mongo_odm/cursor_spec.rb",
    "spec/mongo_odm/document/attribute_methods/dirty_spec.rb",
    "spec/mongo_odm/document/attribute_methods/localization_spec.rb",
    "spec/mongo_odm/document/attribute_methods/query_spec.rb",
    "spec/mongo_odm/document/attribute_methods/read_spec.rb",
    "spec/mongo_odm/document/attribute_methods/write_spec.rb",
    "spec/mongo_odm/document/attribute_methods_spec.rb",
    "spec/mongo_odm/document/callbacks_spec.rb",
    "spec/mongo_odm/document/fields_spec.rb",
    "spec/mongo_odm/document/finders_spec.rb",
    "spec/mongo_odm/document/inspect_spec.rb",
    "spec/mongo_odm/document/persistence_spec.rb",
    "spec/mongo_odm/document/referable_spec.rb",
    "spec/mongo_odm/document/timestamps_spec.rb",
    "spec/mongo_odm/document/validations_spec.rb",
    "spec/mongo_odm/document_spec.rb",
    "spec/mongo_odm/mongo_odm_spec.rb",
    "spec/mongo_odm/reference_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 0"])
      s.add_runtime_dependency(%q<mongo>, [">= 0"])
      s.add_runtime_dependency(%q<bson_ext>, [">= 0"])
      s.add_runtime_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<watchr>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 0"])
      s.add_runtime_dependency(%q<mongo>, [">= 0"])
      s.add_runtime_dependency(%q<bson_ext>, [">= 0"])
      s.add_runtime_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<watchr>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<activemodel>, [">= 0"])
      s.add_dependency(%q<mongo>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<activemodel>, [">= 0"])
      s.add_dependency(%q<mongo>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<activemodel>, [">= 0"])
    s.add_dependency(%q<mongo>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<activemodel>, [">= 0"])
    s.add_dependency(%q<mongo>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
  end
end

