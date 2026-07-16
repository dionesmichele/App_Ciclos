import 'package:flutter/material.dart';
import 'dart:math' as math;

class CicloTab extends StatefulWidget {
  const CicloTab({super.key});

  @override
  State<CicloTab> createState() => _CicloTabState();
}

class _CicloTabState extends State<CicloTab> with SingleTickerProviderStateMixin {
  bool _isHormonizando = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    // Cria o motor que vai girar a borda do círculo (dá uma volta completa a cada 8 segundos)
    _rotationController = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _registrarAcao() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isHormonizando ? '💊 Dose registrada com sucesso!' : '🩸 Início do ciclo registrado!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

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
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: (bool value) {
                  setState(() {
                    _isHormonizando = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            
            // --- CÍRCULO COM BORDA ANIMADA E YIN-YANG NO CENTRO ---
            Center(
              child: AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * math.pi,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Gradiente que vai girar em torno do círculo usando as cores do seu tema!
                        gradient: SweepGradient(
                          colors: [
                            corPrincipal.withOpacity(0.2),
                            corPrincipal,
                            corPrincipal.withOpacity(0.2),
                            corPrincipal,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0), // Espessura da borda animada
                        child: Transform.rotate(
                          angle: -_rotationController.value * 2 * math.pi, // Gira o miolo ao contrário para o texto ficar reto
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
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
                                    color: corPrincipal.withOpacity(0.1),
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
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            
            ElevatedButton.icon(
              onPressed: _registrarAcao,
              icon: Icon(_isHormonizando ? Icons.vaccines : Icons.water_drop),
              label: Text(_isHormonizando ? 'Registrar Dose Hoje' : 'Registrar Início da Menstruação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: corPrincipal,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
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