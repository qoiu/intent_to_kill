enum GameMode{
  intuition(requiredMotive: 8), logic(requiredMotive: 6);

  const GameMode({required this.requiredMotive});
  final int requiredMotive;
}