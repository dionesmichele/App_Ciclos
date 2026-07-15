import 'package:flutter/material.dart';

class CicloTab extends StatefulWidget {
  const CicloTab({super.key});

  @override
  State<CicloTab> createState() => _CicloTabState();
}

class _CicloTabState extends State<CicloTab> {
  bool _isHormonizando = false;

  @override
  Widget build(BuildContext context) {
    final corPrincipal = _isHormonizando ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: SwitchListTile(
                title: const Text('Modo Hormonização', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Altera o monitoramento para controle de doses'),
                value: _isHormonizando,
                activeThumbColor: Theme.of(context).colorScheme.secondary,
                onChanged: (bool value) {
                  setState(() {
                    _isHormonizando = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: corPrincipal, width: 6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/yinyang.gif',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_isHormonizando ? 'Dia 12' : 'Dia 14', style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                    Text(_isHormonizando ? 'da hormonização' : 'do ciclo', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: corPrincipal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _isHormonizando ? 'Próxima dose amanhã' : 'Fase Lútea',
                        style: TextStyle(color: corPrincipal, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(_isHormonizando ? Icons.vaccines : Icons.water_drop),
              label: Text(_isHormonizando ? 'Registrar Dose Hoje' : 'Registrar Início da Menstruação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: corPrincipal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}