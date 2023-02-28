import 'package:catchit/core/package/dospace/dospace.dart' as dospace;

class StorageService {
  //! digitalosean
  String basePath = 'https://catchitmedia.ams3.digitaloceanspaces.com';
  String baseCdnPath = 'https://catchitmedia.ams3.cdn.digitaloceanspaces.com';
  dospace.Spaces spaces = dospace.Spaces(
    region: 'ams3',
    accessKey: 'DO00L4NEWBZVXNW2XEBY',
    secretKey: 'Zh8jbmHBPXQyW0d1zPN2WWQnXwWEVv8142NXRXc56/o',
  );
  final space = {
    "region": "ams3",
    "host": "https://catchitmedia.ams3.digitaloceanspaces.com",
    "bucketId": "catchitmedia",
    "accessKey": "DO00L4NEWBZVXNW2XEBY",
    "secretKey": "Zh8jbmHBPXQyW0d1zPN2WWQnXwWEVv8142NXRXc56/o"
  };
}
