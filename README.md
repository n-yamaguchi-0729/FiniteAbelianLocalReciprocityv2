# Local class field theory in Lean 4.35.0-rc2

This repository includes the complete ClassFieldTheory source bundle and
presents its finite norm-quotient form of local class field theory. The source
corresponds to [ClassFieldTheory commit 7713795234690681b4406ae198b07aa95e82716a](https://github.com/n-yamaguchi-0729/ClassFieldTheory/tree/7713795234690681b4406ae198b07aa95e82716a).

The compared declaration is
`ClassFieldTheory.finiteAbelianLocalReciprocity_quotient`. For a finite
abelian extension `L / K` of a nonarchimedean local field, it states

```text
Kˣ / N_{L/K}(Lˣ) ≃ₜ* Gal(L/K).
```

Here `≃ₜ*` is an isomorphism of topological multiplicative groups. The
Mathlib-only Challenge defines the field norm, its image subgroup, and the
quotient; the Solution imports the completed proof from the included source.

## Additional proved results

The same CFT development also proves:

- a continuous surjective finite Artin map with field-norm kernel in
  [`FiniteAbelianLocalReciprocity.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalReciprocity.lean);
- a coherent family with norm kernels, tower compatibility, and arithmetic
  Frobenius normalization in
  [`FiniteAbelianLocalReciprocityFamilyArithmeticFrobenius.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalReciprocityFamilyArithmeticFrobenius.lean);
- uniqueness of the normalized coherent family in
  [`FiniteAbelianLocalReciprocityFamilyExt.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalReciprocityFamilyExt.lean);
- the local existence/classification theorem as an order isomorphism in
  [`FiniteAbelianLocalExistenceOrderIso.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalExistenceOrderIso.lean).

The theorem placeholder in `Challenge.lean` is deliberate; `Solution.lean`
imports the completed proof.

## Authorship

Astra GPT-6 Codex assisted with Lean development, statement review, and
preparation of this submission interface. Naganori Yamaguchi is the
human author and responsible maintainer.

Licensed under Apache-2.0.
