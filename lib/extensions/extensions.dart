

import 'dart:math';

extension PickRandomElementFromList<T> on List<T>
{
    T? getRandomElement(Random rnd)
    {
      if (length>0)
      {
        return this[rnd.nextInt(length)];
      }
      else
      {
        return null;
      }
      
    }
}