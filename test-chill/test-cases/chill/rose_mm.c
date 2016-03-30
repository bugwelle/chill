


// this source derived from CHILL AST originally from file 'mm.c' as parsed by frontend compiler rose


void mm( float A[256][256], float B[256][256], float C[256][256], int ambn, int an, int bm )
{
  int i;
  int j;
  int n;
  for (i = 0; i < an; i++) {
    for (j = 0; j < bm; j++) {
      C[i][j] = 0.0f;
      for (n = 0; n < ambn; n++) {
        C[i][j] = (C[i][j] + A[i][n] * B[n][j]);
      }
    }
  }

}
