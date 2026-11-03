# S&M Hotel

Aplicativo Flutter de planejamento de viagens (Aula 08 - Aplicações Mobile).

## Funcionalidades
- Login consumindo o Json Server (`GET /usuario?email=&senha=`)
- Cadastro via `POST /cadastro-usuario`
- Home com `Scaffold`, `AppBar` e `ListView` com 10 destinos
- Classe `Destino` (Stateful) com imagem 393x250, nome, valores e 4 botões:
  - B1 `dias()` - incrementa diárias
  - B2 `pessoas()` - incrementa acompanhantes
  - B3 `calctotal()` - calcula via Provider (carrinho de compras)
  - B4 `limpar()` - zera os camposS
- Total = (n_diarias * valord) + (n_pessoas * valorp), tudo `int`
- Tela de checkout (estilo app delivery) com forma de pagamento; **Pix = 10% de desconto**

## Como executar
1. Coloque as 10 imagens na pasta `imagens/`: `angra.jpg, arraial.jpg, chile.jpg, flori.jpg, jeri.jpg, lasvegas.jpg, madri.jpg, orlando.jpg, paris.jpg, roma.jpg`
2. `flutter create .` (gera as pastas android/ios, se ainda não existirem)
3. `flutter pub get`
4. Em outro terminal, inicie a API: `npx json-server --watch db.json --port 3000`
5. Ajuste `baseUrl` em `lib/login.dart` (emulador Android: `10.0.2.2`; demais: `localhost`)
6. `flutter run`

Login de teste: `admin@smhotel.com` / `123456`

```
git init
git add .
git commit -m "App S&M Hotel"
git remote add origin <URL_DO_REPOSITORIO>
git push -u origin main
```
