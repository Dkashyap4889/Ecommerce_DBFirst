using System;
using System.Collections.Generic;

namespace Ecommerce_DBFirst.Models;

public partial class Order
{
    public int Id { get; set; }

    public int CustomerId { get; set; }

    public bool? Delivered { get; set; }

    public virtual Customer Customer { get; set; } = null!;
}
