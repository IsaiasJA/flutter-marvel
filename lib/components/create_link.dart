import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'link_list.dart';

const String CREATE_LINK_MUTATION = '''
  mutation PostMutation(
    \$url: String!
    \$name: String!
    \$description: String!
    \$comic: String!
  ) {
    createLink(url: \$url, name: \$name, description: \$description, comic: \$comic) {
      id
      url
      name
      description
      comic
    }
  }
''';

class CreateLinkScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final urlController = useTextEditingController();
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final comicController = useTextEditingController();

    final createLinkMutation = useMutation(
      MutationOptions(
        document: gql(CREATE_LINK_MUTATION),
        onCompleted: (_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LinkListScreen()),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Link'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'URL'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripcion'),
            ),
            TextField(
              controller: comicController,
              decoration: InputDecoration(labelText: 'Comic'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createLinkMutation.runMutation({
                  'url': urlController.text,
                  'name': nameController.text,
                  'description': descriptionController.text,
                  'comic': comicController.text,
                });
              },
              child: Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
