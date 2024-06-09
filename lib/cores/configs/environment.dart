enum EFlavor { dev, staging, prod }

class Environment {
  static EFlavor flavor = EFlavor.dev;

  static String baseUrl() {
    switch (flavor) {
      case EFlavor.dev:
        return 'https://app.jala.tech/api';
      case EFlavor.staging:
        return 'https://app.jala.tech/api';
      case EFlavor.prod:
        return 'https://app.jala.tech/api';
      default:
        return '';
    }
  }
}
