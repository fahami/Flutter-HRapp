import 'package:equatable/equatable.dart';

class Role extends Equatable {
	final int? id;
	final DateTime? dateCreated;
	final DateTime? dateUpdated;
	final String? title;
	final String? description;
	final String? requirement;

	const Role({
		this.id, 
		this.dateCreated, 
		this.dateUpdated, 
		this.title, 
		this.description, 
		this.requirement, 
	});

	factory Role.fromJson(Map<String, dynamic> json) => Role(
				id: json['id'] as int?,
				dateCreated: json['date_created'] == null
						? null
						: DateTime.parse(json['date_created'] as String),
				dateUpdated: json['date_updated'] == null
						? null
						: DateTime.parse(json['date_updated'] as String),
				title: json['title'] as String?,
				description: json['description'] as String?,
				requirement: json['requirement'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'date_created': dateCreated?.toIso8601String(),
				'date_updated': dateUpdated?.toIso8601String(),
				'title': title,
				'description': description,
				'requirement': requirement,
			};

	@override
	List<Object?> get props {
		return [
				id,
				dateCreated,
				dateUpdated,
				title,
				description,
				requirement,
		];
	}
}
