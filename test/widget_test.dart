// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:aplicativo_sm_travel_apm/main.dart';
import 'package:aplicativo_sm_travel_apm/carrinho.dart';

void main() {
  testWidgets('Login screen is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(create: (_) => Carrinho(), child: const MyApp()),
    );
    await tester.pump();

    expect(find.text('S&M Hotel - Login'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  test('Cart calculation applies the configured prices', () {
    final carrinho = Carrinho();
    final total = carrinho.calctotal(
      nome: 'Paris',
      nDiarias: 3,
      valord: 546,
      nPessoas: 2,
      valorp: 95,
    );

    expect(total, 1828);
    expect(carrinho.total, 1828);
  });
}
