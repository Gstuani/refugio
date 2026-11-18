import 'package:flutter/material.dart';
import 'package:refugio/pages/explorar_page.dart';

class BoasVindasPage extends StatelessWidget {
  const BoasVindasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            const SizedBox(height: 48),
            const Row(
              children: [
                Icon(
                  Icons.wb_shade_rounded,
                  size: 36,
                  color: Color(0xff145c56),
                ),
                SizedBox(width: 12),
                Text(
                  'refúgio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff145c56),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 52),
            Container(
              height: 144,
              decoration: BoxDecoration(
                color: const Color(0xffe0ede5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.park_outlined,
                size: 82,
                color: Color(0xff39775c),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Um lugar para\nrespirar no caminho.',
              style: TextStyle(
                fontSize: 34,
                height: 1.15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Encontre pontos com água, sombra e espaço para descansar nos dias de calor.',
              style: TextStyle(
                fontSize: 17,
                height: 1.5,
                color: Color(0xff526561),
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ExplorarPage()),
                );
              },
              child: const Text('Explorar pontos'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Dados demonstrativos. Confirme local e horários antes de usar.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xff526561),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
